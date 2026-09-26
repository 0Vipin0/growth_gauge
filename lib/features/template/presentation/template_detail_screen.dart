import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/database/app_database.dart';
import '../../../core/events/domain_event_dispatcher.dart';
import '../../catalog/infrastructure/exercise_repository.dart';
import '../../session/application/session_use_cases.dart';
import '../../session/infrastructure/session_repository.dart';
import '../../session/presentation/active_session_screen.dart';
import '../application/template_use_cases.dart';
import '../domain/template_enums.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_revision.dart';
import '../infrastructure/template_repository.dart';
import 'template_editor_screen.dart';

class const TemplateDetailScreen({
  super.key,
  required final WorkoutTemplate template,
  required final ITemplateRepository repository,
  required final IExerciseRepository exerciseRepository,
  required final TemplateUseCases useCases,
  required final String userId,
}) extends StatefulWidget {
  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState() extends State<TemplateDetailScreen> {
  late WorkoutTemplate _template;
  bool _starting = false;

  @override
  void initState() {
    super.initState();
    _template = widget.template;
  }

  Future<void> _edit() async {
    final currentId = _template.currentRevisionId;
    if (currentId == null) return;
    final currentResult = await widget.repository.getRevision(currentId);
    if (currentResult.isError || !mounted) return;
    var revision = currentResult.dataOrNull!;
    if (revision.status != TemplateRevisionStatus.draft) {
      final draft = await widget.useCases.createDraftFromCurrent(
        _template.id,
        changeSummary: 'Edited in template builder',
      );
      if (draft.isError) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(draft.errorOrNull!.message)));
        }
        return;
      }
      revision = draft.dataOrNull!;
    }
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TemplateEditorScreen(
          revision: revision,
          repository: widget.repository,
          exerciseRepository: widget.exerciseRepository,
          useCases: widget.useCases,
          userId: widget.userId,
        ),
      ),
    );
    final latest = await widget.repository.getTemplate(_template.id);
    if (latest.isSuccess && mounted) {
      setState(() => _template = latest.dataOrNull!);
    }
  }

  Future<void> _start(WorkoutTemplateRevision revision) async {
    if (_starting) return;
    setState(() => _starting = true);
    final database = Provider.of<AppDatabase>(context, listen: false);
    final events = DomainEventDispatcher();
    final useCases = SessionUseCases(
      templates: widget.repository,
      sessions: WorkoutSessionRepository(database),
      events: events,
    );
    try {
      final created = await useCases.createFromRevision(
        revisionId: revision.id,
        userId: widget.userId,
      );
      if (!mounted) return;
      if (created.isError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(created.errorOrNull!.message)));
        return;
      }
      final started = await useCases.start(created.dataOrNull!.id);
      if (!mounted) return;
      if (started.isError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(started.errorOrNull!.message)));
        return;
      }
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ActiveSessionScreen(
            session: started.dataOrNull!,
            useCases: useCases,
            exerciseRepository: widget.exerciseRepository,
          ),
        ),
      );
    } finally {
      await events.dispose();
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(_template.name)),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: _edit,
      icon: const Icon(Icons.edit),
      label: const Text('Edit template'),
    ),
    body: FutureBuilder(
      future: _template.currentRevisionId == null
          ? null
          : widget.repository.getRevision(_template.currentRevisionId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final result = snapshot.data!;
        if (result.isError) {
          return const Center(child: Text('Current revision is unavailable'));
        }
        final revision = result.dataOrNull!;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              _template.description.isEmpty
                  ? 'Build a reusable workout plan.'
                  : _template.description,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.history),
              title: Text('Revision ${revision.revisionNumber}'),
              subtitle: Text(revision.status.name.toUpperCase()),
            ),
            if (revision.blocks.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No workout blocks yet. Edit this template to add a block.',
                ),
              ),
            if (revision.status == TemplateRevisionStatus.published &&
                revision.blocks.isNotEmpty) ...[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _starting ? null : () => _start(revision),
                icon: const Icon(Icons.play_arrow),
                label: Text(_starting ? 'Starting…' : 'Start workout'),
              ),
            ],
            ...revision.blocks.map(
              (block) => Card(
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(block.name),
                  subtitle: Text(
                    '${block.items.length} exercises · ${block.rounds} round(s)',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
