import 'package:flutter/material.dart';

import 'package:growth_gauge/utils/constants.dart';

import '../catalog/infrastructure/exercise_repository.dart';
import '../session/application/session_use_cases.dart';
import '../session/domain/session_enums.dart';
import '../session/infrastructure/session_repository.dart';
import '../session/presentation/active_session_screen.dart';
import '../session/presentation/session_recovery_dialog.dart';
import '../settings/settings_page.dart';
import 'fitness_hub_page.dart';

class const HomePage({
  super.key,
  required final IWorkoutSessionRepository sessionRepository,
  required final SessionUseCases sessionUseCases,
  required final IExerciseRepository exerciseRepository,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState() extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerRecovery());
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kTabletScreenSize) {
          return const DesktopHomePage();
        } else {
          return const MobileHomePage();
        }
      },
    );
  }
}

class const MobileHomePage({super.key}) extends StatefulWidget {
  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState() extends State<MobileHomePage> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [FitnessHubPage(), SettingsPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
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
      ),
    );
  }
}

class const DesktopHomePage({super.key}) extends StatefulWidget {
  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState() extends State<DesktopHomePage> {
  int _selectedIndex = 0;

  bool _isRailExtended = false;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _toggleRail() {
    setState(() {
      _isRailExtended = !_isRailExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            extended: _isRailExtended,
            onDestinationSelected: _onDestinationSelected,
            destinations: const <NavigationRailDestination>[
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
              tooltip: _isRailExtended ? 'Collapse' : 'Expand',
              icon: Icon(
                _isRailExtended ? Icons.chevron_left : Icons.chevron_right,
              ),
              onPressed: _toggleRail,
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
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: const [FitnessHubPage(), SettingsPage()],
            ),
          ),
        ],
      ),
    );
  }
}
