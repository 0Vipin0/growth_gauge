import 'package:flutter/material.dart';

import '../../../core/events/domain_event_dispatcher.dart';
import '../../../features/catalog/infrastructure/exercise_repository.dart';
import '../../session/application/session_use_cases.dart';
import '../../session/domain/session_enums.dart';
import '../../session/infrastructure/session_repository.dart';
import '../../session/presentation/active_session_screen.dart';
import '../../session/presentation/session_recovery_dialog.dart';
import '../application/template_use_cases.dart';
import '../domain/workout_template.dart';
import '../infrastructure/template_repository.dart';
import 'template_detail_screen.dart';

class TemplateListScreen extends StatefulWidget {
  const TemplateListScreen(
      {super.key,
      required this.repository,
      required this.exerciseRepository,
      required this.sessionRepository,
      required this.useCases,
      required this.userId});
  final ITemplateRepository repository;
  final IExerciseRepository exerciseRepository;
  final IWorkoutSessionRepository sessionRepository;
  final TemplateUseCases useCases;
  final String userId;

  @override
  State<TemplateListScreen> createState() => _TemplateListScreenState();
}

class _TemplateListScreenState extends State<TemplateListScreen> {
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
    final events = DomainEventDispatcher();
    final sessionUseCases = SessionUseCases(
      templates: widget.repository,
      sessions: widget.sessionRepository,
      events: events,
    );
    var session = selected;
    final recovered = await sessionUseCases.recoverIncomplete(session.id);
    if (recovered.isError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(recovered.errorOrNull!.message)),
        );
      }
      await events.dispose();
      return;
    }
    session = recovered.dataOrNull!;
    if (session.status == SessionStatus.completed) {
      await events.dispose();
      return;
    }
    if (!mounted) {
      await events.dispose();
      return;
    }
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ActiveSessionScreen(
        session: session,
        useCases: sessionUseCases,
        exerciseRepository: widget.exerciseRepository,
      ),
    ));
    await events.dispose();
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
                  decoration: const InputDecoration(labelText: 'Name')),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => Navigator.pop(context, name.text),
                    child: const Text('Create'))
              ],
            ));
    name.dispose();
    if (result == null || !mounted) return;
    final created =
        await widget.useCases.create(name: result, createdById: widget.userId);
    if (created.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(created.errorOrNull!.message)));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Workout templates')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _create,
            icon: const Icon(Icons.add),
            label: const Text('New template')),
        body: StreamBuilder<List<WorkoutTemplate>>(
          stream: _templates,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Could not load templates'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final templates =
                snapshot.data!.where((t) => !t.isArchived).toList();
            if (templates.isEmpty) {
              return const Center(
                  child: Text('Create a template to start planning workouts'));
            }
            return ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, i) {
                  final template = templates[i];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.view_agenda)),
                    title: Text(template.name),
                    subtitle: Text(template.description.isEmpty
                        ? 'No description'
                        : template.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TemplateDetailScreen(
                            template: template,
                            repository: widget.repository,
                            exerciseRepository: widget.exerciseRepository,
                            useCases: widget.useCases,
                            userId: widget.userId))),
                  );
                });
          },
        ),
      );
}
