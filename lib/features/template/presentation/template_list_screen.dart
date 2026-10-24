import 'package:flutter/material.dart';

import '../../catalog/infrastructure/exercise_repository.dart';
import '../../session/application/session_use_cases.dart';
import '../../session/domain/session_enums.dart';
import '../../session/infrastructure/session_repository.dart';
import '../../session/presentation/active_session_screen.dart';
import '../../session/presentation/session_recovery_dialog.dart';
import '../application/template_use_cases.dart';
import '../domain/workout_template.dart';
import '../infrastructure/template_repository.dart';
import 'template_detail_screen.dart';

class const TemplateListScreen({
    super.key,
    required final ITemplateRepository repository,
    required final IExerciseRepository exerciseRepository,
    required final IWorkoutSessionRepository sessionRepository,
    required final SessionUseCases sessionUseCases,
    required final TemplateUseCases useCases,
    required final String userId,
  }) extends StatefulWidget {
  @override
  State<TemplateListScreen> createState() => _TemplateListScreenState();
}

class _TemplateListScreenState() extends State<TemplateListScreen> {
  late Stream<List<WorkoutTemplate>> _templates;

  @override
  void initState() {
    super.initState();
    _templates = widget.repository.watchTemplates();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerRecovery());
  }

  Future<void> _offerRecovery() async {
    final result = await widget.sessionRepository.listUnfinished(widget.userId);
    if (!mounted || result.isError || result.dataOrNull!.isEmpty) return;
    final sessions = result.dataOrNull!;
    final selected = await showSessionRecoveryDialog(context, sessions);
    if (selected == null || !mounted) {
      return;
    }
    var session = selected;
    final recovered = await widget.sessionUseCases.recoverIncomplete(
      session.id,
    );
    if (recovered.isError) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(recovered.errorOrNull!.message)));
      }
      return;
    }
    session = recovered.dataOrNull!;
    if (session.status == SessionStatus.completed) {
      return;
    }
    if (!mounted) {
      return;
    }
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

  Future<void> _create() async {
    final name = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New workout template'),
        content: TextField(
          controller: name,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, name.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    name.dispose();
    if (result == null || !mounted) return;
    final created = await widget.useCases.create(
      name: result,
      createdById: widget.userId,
    );
    if (created.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(created.errorOrNull!.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Workout templates'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('New template'),
      ),
      body: StreamBuilder<List<WorkoutTemplate>>(
        stream: _templates,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load templates'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final templates = snapshot.data!.where((t) => !t.isArchived).toList();
          if (templates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.view_agenda_outlined,
                    size: 64,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Create a template to start planning workouts',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth >= 900 ? 32 : 20,
                    vertical: 24,
                  ),
                  itemCount: templates.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final template = templates[i];
                    return Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TemplateDetailScreen(
                              template: template,
                              repository: widget.repository,
                              exerciseRepository: widget.exerciseRepository,
                              useCases: widget.useCases,
                              sessionUseCases: widget.sessionUseCases,
                              userId: widget.userId,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.view_agenda,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      template.name,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.onSurface,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      template.description.isEmpty
                                          ? 'No description'
                                          : template.description,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
