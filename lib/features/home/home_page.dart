import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../catalog/infrastructure/exercise_repository.dart';
import '../common/presentation/widgets/responsive_layout.dart';
import '../session/application/session_use_cases.dart';
import '../session/domain/session_enums.dart';
import '../session/infrastructure/session_repository.dart';
import '../session/presentation/active_session_screen.dart';
import '../session/presentation/session_recovery_dialog.dart';
import '../settings/settings_page.dart';
import '../template/template.dart';
import 'fitness_hub_page.dart';

class const HomePage({
  super.key,
  required final IWorkoutSessionRepository sessionRepository,
  required final SessionUseCases sessionUseCases,
  required final IExerciseRepository exerciseRepository,
  required final ITemplateRepository templateRepository,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState() extends State<HomePage> {
  int _selectedIndex = 0;
  bool? _railExtendedOverride;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerRecovery());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _offerRecovery() async {
    final result = await widget.sessionRepository.listUnfinished(widget.userId);
    if (!mounted || result.isError || result.dataOrNull!.isEmpty) return;
    final selected = await showSessionRecoveryDialog(
      context,
      result.dataOrNull!,
    );
    if (selected == null || !mounted) return;
    final recovery = await widget.sessionUseCases.recoverIncomplete(
      selected.id,
    );
    if (!mounted) return;
    if (recovery.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(recovery.errorOrNull!.message)));
      return;
    }
    final session = recovery.dataOrNull!;
    if (session.status == SessionStatus.completed) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActiveSessionScreen(
          session: session,
          useCases: widget.sessionUseCases,
          exerciseRepository: widget.exerciseRepository,
        ),
      ),
    );
  }

  void _selectDestination(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 300),
      curve: MediaQuery.disableAnimationsOf(context)
          ? Curves.linear
          : Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final sizeClass = AppWindowSizeClass.fromWidth(constraints.maxWidth);
      final isCompact = sizeClass == AppWindowSizeClass.compact;
      final railExtended =
          _railExtendedOverride ?? sizeClass == AppWindowSizeClass.expanded;

      return FocusTraversalGroup(
        child: Scaffold(
          body: Row(
            children: [
              if (!isCompact) ...[
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  extended: railExtended,
                  onDestinationSelected: _selectDestination,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.fitness_center),
                      label: Text('Training'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                  leading: IconButton(
                    tooltip: railExtended ? 'Collapse' : 'Expand',
                    icon: Icon(
                      railExtended ? Icons.chevron_left : Icons.chevron_right,
                    ),
                    onPressed: () =>
                        setState(() => _railExtendedOverride = !railExtended),
                  ),
                  selectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  selectedLabelTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
              ],
              Expanded(
                child: PageView(
                  key: const PageStorageKey<String>('home-destinations'),
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _selectedIndex = index),
                  children: [
                    FitnessHubPage(
                      templateRepository: widget.templateRepository,
                      onStartTemplate: (template) async {
                        // 1. Fetch all revisions for this template
                        final revisionsResult = await widget.templateRepository
                            .getRevisions(template.id);
                        if (!mounted) return;
                        if (revisionsResult.isError ||
                            revisionsResult.dataOrNull!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No revisions found for this template',
                              ),
                            ),
                          );
                          return;
                        }

                        final revisions = revisionsResult.dataOrNull!;

                        // 2. Filter for published revisions and sort descending by revision number to get the latest complete one
                        final publishedRevisions =
                            revisions
                                .where((rev) => rev.status.name == 'published')
                                .toList()
                              ..sort(
                                (a, b) => b.revisionNumber.compareTo(
                                  a.revisionNumber,
                                ),
                              );

                        if (publishedRevisions.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No published revision found for this template',
                              ),
                            ),
                          );
                          return;
                        }

                        final targetRevision = publishedRevisions.first;

                        // 3. Create session from the correct published revision
                        final createResult = await widget.sessionUseCases
                            .createFromRevision(
                              revisionId: targetRevision.id,
                              userId: widget.userId,
                            );
                        if (!mounted) return;
                        if (createResult.isError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(createResult.errorOrNull!.message),
                            ),
                          );
                          return;
                        }

                        // 4. Start session and navigate to active screen
                        final session = createResult.dataOrNull!;
                        final startResult = await widget.sessionUseCases.start(
                          session.id,
                        );
                        if (!mounted) return;
                        if (startResult.isError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(startResult.errorOrNull!.message),
                            ),
                          );
                          return;
                        }

                        final activeSession = startResult.dataOrNull!;
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ActiveSessionScreen(
                              session: activeSession,
                              useCases: widget.sessionUseCases,
                              exerciseRepository: widget.exerciseRepository,
                            ),
                          ),
                        );
                      },
                      onProfileTap: () => context.push(appRouteProfile),
                      onAnalyticsTap: () => context.push(appRouteAnalytics),
                      onCatalogTap: () => context.push(appRouteExerciseCatalog),
                      onTemplateTap: () =>
                          context.push(appRouteWorkoutTemplates),
                    ),
                    const SettingsPage(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isCompact
              ? BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _selectDestination,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.fitness_center),
                      label: 'Training',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                  selectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                )
              : null,
        ),
      );
    },
  );
}
