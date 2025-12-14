import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/ui/core/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'edit_timer_page.dart';
import 'provider/provider.dart';
import 'timer_details_page.dart';

class ReusableTimerWidget extends StatelessWidget {
  final TimerModel timerModel;
  final VoidCallback onRemove;
  final VoidCallback onUpdateTarget;

  const ReusableTimerWidget({
    super.key,
    required this.timerModel,
    required this.onRemove,
    required this.onUpdateTarget,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReusableTimerProvider(timer: timerModel),
      child: Consumer<ReusableTimerProvider>(
        builder: (context, timerProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  title: Text(
                    timerModel.name,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Passed: ${timerProvider.currentInterval.inSeconds} seconds',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelLarge?.fontSize,
                        ),
                      ),
                      if (timerModel.target != null)
                        Text('Target: ${timerModel.target!.inMinutes} minutes',
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.fontSize,
                                color: Colors.green)),
                      if (timerModel.target == null)
                        TextButton(
                          onPressed: onUpdateTarget,
                          child: const Text('Add Target',
                              style: TextStyle(color: Colors.red)),
                        ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: timerModel.tags
                                ?.map((tag) => Chip(
                                      label: Text(tag),
                                    ))
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildAction(timerProvider, context),
                  ),
                  onTap: () {
                    context.pushTransition(
                      type: PageTransitionType.bottomToTop,
                      child: TimerDetailsPage(timer: timerModel),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildAction(
    ReusableTimerProvider timerProvider,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Widget> actions = [
      IconButton(
        icon: Icon(
          timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
        ),
        tooltip: timerProvider.isRunning ? 'Pause' : 'Start',
        onPressed: () {
          timerProvider.startOrPauseTimer();
          Provider.of<TimerListProvider>(
            context,
            listen: false,
          ).updateTimer(timerProvider.timer);
        },
      ),
      IconButton(
        icon: const Icon(Icons.refresh),
        tooltip: 'Reset',
        onPressed: () {
          timerProvider.resetTimer();
          Provider.of<TimerListProvider>(
            context,
            listen: false,
          ).updateTimer(timerProvider.timer);
        },
      ),
    ];

    if (screenWidth > kDesktopScreenSize) {
      if (timerModel.target != null) {
        actions.add(
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Update Target',
            onPressed: onUpdateTarget,
          ),
        );
      }
      actions.add(
        IconButton(
          icon: const Icon(Icons.edit_note),
          tooltip: 'Edit Details',
          onPressed: () {
            context.pushTransition(
              type: PageTransitionType.bottomToTop,
              child: EditTimerPage(timer: timerModel),
            );
          },
        ),
      );
      actions.add(
        IconButton(
          icon: const Icon(Icons.label),
          tooltip: 'Manage Tags',
          onPressed: () {
            _manageTagsDialog(context);
          },
        ),
      );
      actions.add(
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Delete',
          onPressed: onRemove,
        ),
      );
    } else {
      actions.add(
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'UpdateTargetAction') {
              onUpdateTarget();
            } else if (value == 'EditDetailsAction') {
              context.pushTransition(
                type: PageTransitionType.bottomToTop,
                child: EditTimerPage(timer: timerModel),
              );
            } else if (value == 'ManageTagsAction') {
              _manageTagsDialog(context);
            } else if (value == 'DeleteAction') {
              onRemove();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'UpdateTargetAction',
              child: Text('Update Target'),
            ),
            const PopupMenuItem(
              value: 'EditDetailsAction',
              child: Text('Edit Details'),
            ),
            const PopupMenuItem(
              value: 'ManageTagsAction',
              child: Text('Manage Tags'),
            ),
            const PopupMenuItem(
              value: 'DeleteAction',
              child: Text('Delete'),
            ),
          ],
        ),
      );
    }

    return actions;
  }

  void _manageTagsDialog(BuildContext context) {
    final timerProvider =
        Provider.of<TimerListProvider>(context, listen: false);
    timerProvider.initializeTags(timerModel.tags);

    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController tagController = TextEditingController();

        return AlertDialog(
          title: const Text('Manage Tags'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  labelText: 'Add Tag',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    timerProvider.addTag(value);
                    tagController.clear();
                  }
                },
              ),
              const SizedBox(height: 8),
              Consumer<TimerListProvider>(
                builder: (context, provider, child) {
                  return Wrap(
                    spacing: 8.0,
                    children: provider.updatedTags
                        .map((tag) => Chip(
                              label: Text(tag),
                              onDeleted: () {
                                provider.removeTag(tag);
                              },
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                timerProvider.saveTags(timerModel);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
