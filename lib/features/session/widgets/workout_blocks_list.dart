import 'package:flutter/material.dart';

import '../domain/execution_set.dart';
import '../domain/session_enums.dart';
import '../domain/workout_session.dart';

class const WorkoutBlocksList({
    super.key,
    required final WorkoutSession session,
    required final Map<String, String> exerciseNames,
    required final bool actionsEnabled,
    required final ValueChanged<ExecutionSet> onRecord,
    required final ValueChanged<ExecutionSet> onEditTarget,
    required final ValueChanged<ExecutionSet> onDelete,
    required final ValueChanged<ExecutionSet> onSkip,
    required final ValueChanged<ExecutionSet> onRest,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final block in session.blocks) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Material(
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text(
                  block.name,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${block.type.name} · ${block.rounds} round(s)',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        for (final item in block.items) ...[
                          const Divider(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              exerciseNames[item.exerciseId] ?? item.exerciseId,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          for (final set in item.sets)
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Set ${set.setNumber}  ·  ${set.targetWeight == null ? '' : '${set.targetWeight} kg'} ${set.targetReps == null ? '' : '× ${set.targetReps}'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(set.status.name.toUpperCase()),
                              trailing:
                                  set.status == ExecutionSetStatus.completed
                                  ? PopupMenuButton<_SetAction>(
                                      enabled: actionsEnabled,
                                      onSelected: (action) {
                                        if (action == _SetAction.startRest) {
                                          onRest(set);
                                        } else {
                                          onDelete(set);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        if (set.plannedRestSeconds > 0)
                                          const PopupMenuItem(
                                            value: _SetAction.startRest,
                                            child: Text('Start rest'),
                                          ),
                                        const PopupMenuItem(
                                          value: _SetAction.delete,
                                          child: Text('Delete set'),
                                        ),
                                      ],
                                    )
                                  : set.status == ExecutionSetStatus.skipped
                                  ? PopupMenuButton<_SetAction>(
                                      enabled: actionsEnabled,
                                      onSelected: (_) => onDelete(set),
                                      itemBuilder: (context) => const [
                                        PopupMenuItem(
                                          value: _SetAction.delete,
                                          child: Text('Delete set'),
                                        ),
                                      ],
                                    )
                                  : PopupMenuButton<_SetAction>(
                                      enabled: actionsEnabled,
                                      onSelected: (action) {
                                        switch (action) {
                                          case _SetAction.editTarget:
                                            onEditTarget(set);
                                          case _SetAction.record:
                                            onRecord(set);
                                          case _SetAction.startRest:
                                            onRest(set);
                                          case _SetAction.skip:
                                            onSkip(set);
                                          case _SetAction.delete:
                                            onDelete(set);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: _SetAction.editTarget,
                                          child: Text('Edit target'),
                                        ),
                                        const PopupMenuItem(
                                          value: _SetAction.record,
                                          child: Text('Log set'),
                                        ),
                                        const PopupMenuItem(
                                          value: _SetAction.skip,
                                          child: Text('Skip set'),
                                        ),
                                        const PopupMenuItem(
                                          value: _SetAction.delete,
                                          child: Text('Delete set'),
                                        ),
                                      ],
                                    ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

enum _SetAction() { editTarget, record, startRest, skip, delete }
