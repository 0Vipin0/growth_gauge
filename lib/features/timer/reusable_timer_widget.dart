import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';
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
            children: [
              Card(
                child: ListTile(
                  title: Text(timerModel.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Passed: ${timerProvider.currentInterval.inSeconds} seconds',
                      ),
                      if (timerModel.target != null)
                        Text('Target: ${timerModel.target!.inMinutes} minutes',
                            style: const TextStyle(color: Colors.green)),
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
                    children: [
                      IconButton(
                        icon: Icon(
                          timerProvider.isRunning
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
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
                        onPressed: () {
                          timerProvider.resetTimer();
                          Provider.of<TimerListProvider>(
                            context,
                            listen: false,
                          ).updateTimer(timerProvider.timer);
                        },
                      ),
                      if (timerModel.target != null)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: onUpdateTarget,
                        ),
                      IconButton(
                        icon: const Icon(Icons.label),
                        onPressed: () {
                          final timerProvider = Provider.of<TimerListProvider>(
                              context,
                              listen: false);
                          timerProvider.initializeTags(timerModel.tags);

                          showDialog(
                            context: context,
                            builder: (context) {
                              final TextEditingController tagController =
                                  TextEditingController();

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
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onRemove,
                      ),
                    ],
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
}
