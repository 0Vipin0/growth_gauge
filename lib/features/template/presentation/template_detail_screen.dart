import 'package:flutter/material.dart';

import '../../catalog/infrastructure/exercise_repository.dart';
import '../../session/application/session_use_cases.dart';
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
  required final SessionUseCases sessionUseCases,
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
    try {
      final created = await widget.sessionUseCases.createFromRevision(
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
      final started = await widget.sessionUseCases.start(
        created.dataOrNull!.id,
      );
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
            useCases: widget.sessionUseCases,
            exerciseRepository: widget.exerciseRepository,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(_template.name), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _edit,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
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
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth >= 900 ? 32 : 20,
                    vertical: 24,
                  ),
                  children: [
                    Text(
                      _template.description.isEmpty
                          ? 'Build a reusable workout plan.'
                          : _template.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.history, color: colorScheme.primary),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Revision ${revision.revisionNumber}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  revision.status.name.toUpperCase(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (revision.blocks.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text(
                            'No workout blocks yet. Edit this template to add a block.',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    if (revision.status == TemplateRevisionStatus.published &&
                        revision.blocks.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: _starting ? null : () => _start(revision),
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow),
                        label: Text(_starting ? 'Starting…' : 'Start workout'),
                      ),
                    ],
                    const SizedBox(height: 16),
                    ...revision.blocks.map(
                      (block) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          elevation: 0,
                          color: colorScheme.surfaceContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer.withValues(
                                  alpha: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.fitness_center,
                                color: colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              block.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${block.items.length} exercises · ${block.rounds} round(s)',
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
