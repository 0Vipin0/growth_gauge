import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../catalog/catalog.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../../session/application/session_use_cases.dart';
import '../application/template_use_cases.dart';
import '../domain/template_enums.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_revision.dart';
import '../infrastructure/template_repository.dart';

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
    await context.push(appRouteTemplateEditor, extra: revision);
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
      await context.push(appRouteActiveSession, extra: started.dataOrNull);
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  Future<void> _toggleArchive() async {
    final result = await widget.useCases.archiveTemplate(
      _template.id,
      isArchived: !_template.isArchived,
    );
    if (result.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
    } else if (mounted) {
      context.pop();
    }
  }

  Future<void> _confirmAndDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permanently delete template?'),
        content: Text('This action cannot be undone for "${_template.name}".'),
        actions: [
          AppButton.ghost(
            label: 'Cancel',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton.primary(
            label: 'Delete',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      final result = await widget.useCases.deleteTemplate(_template.id);
      if (result.isError && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      } else if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(_template.name),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'archive') {
                _toggleArchive();
              } else if (value == 'delete') {
                _confirmAndDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(
                      _template.isArchived ? Icons.unarchive : Icons.archive,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _template.isArchived
                          ? 'Restore template'
                          : 'Archive template',
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_forever,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Delete permanently',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
                    AppCard(
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
                      SizedBox(
                        width: double.infinity,
                        child: AppButton.primary(
                          label: _starting ? 'Starting…' : 'Start workout',
                          icon: Icons.play_arrow,
                          onPressed: _starting ? null : () => _start(revision),
                          isLoading: _starting,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    ...revision.blocks.map(
                      (block) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          padding: EdgeInsets.zero, // Let ExpansionTile handle its own internal padding
                          child: ExpansionTile(
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
                            children: [
                              const Divider(height: 1),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: block.items.length,
                                itemBuilder: (context, index) {
                                  final item = block.items[index];
                                  return FutureBuilder(
                                    future: widget.exerciseRepository.findById(
                                      item.exerciseId,
                                    ),
                                    builder: (context, snapshot) {
                                      final exercise =
                                          snapshot.data?.dataOrNull;
                                      return ListTile(
                                        title: Text(
                                          exercise?.name ?? item.exerciseId,
                                        ),
                                        subtitle: exercise != null
                                            ? Text(
                                                exercise
                                                    .classification
                                                    .bodyRegions
                                                    .map((e) => e.displayName)
                                                    .join(', '),
                                              )
                                            : null,
                                        trailing: IconButton(
                                          icon: const Icon(Icons.chevron_right),
                                          tooltip: 'View exercise details',
                                          onPressed: exercise == null
                                              ? null
                                              : () async {
                                                  // Navigate to the exercise detail screen using GoRouter
                                                  await context.push(
                                                    appRouteExerciseDetail,
                                                    extra: exercise,
                                                  );
                                                },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
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
