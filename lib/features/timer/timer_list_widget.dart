import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'add_timer_page.dart';
import 'model/model.dart';
import 'provider/provider.dart';
import 'reusable_timer_widget.dart';

class TimerListWidget extends StatelessWidget {
  const TimerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerListProvider = Provider.of<TimerListProvider>(context);
    final List<String> selectedTags = []; // Track selected tags for filtering

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timers'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (tag) {
              if (selectedTags.contains(tag)) {
                selectedTags.remove(tag);
              } else {
                selectedTags.add(tag);
              }
              timerListProvider.filterTimersByTags(selectedTags);
            },
            itemBuilder: (context) {
              return timerListProvider.getAllTags().map((tag) {
                return PopupMenuItem<String>(
                  value: tag,
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedTags.contains(tag),
                        onChanged: (isSelected) {
                          if (isSelected == true) {
                            selectedTags.add(tag);
                          } else {
                            selectedTags.remove(tag);
                          }
                          timerListProvider.filterTimersByTags(selectedTags);
                        },
                      ),
                      Text(tag),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: timerListProvider.filteredTimers.isEmpty
          ? _buildEmptyTimerList(context, timerListProvider)
          : ListView.builder(
              itemCount: timerListProvider.filteredTimers.length,
              itemBuilder: (context, index) {
                final timer = timerListProvider.filteredTimers[index];
                return ReusableTimerWidget(
                  timerModel: timer,
                  onRemove: () => showDeleteDialog(context, timer),
                  onUpdateTarget: () => showUpdateTargetDialog(context, timer),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushTransition(
            type: PageTransitionType.bottomToTop,
            child: const AddTimerPage(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyTimerList(
    BuildContext context,
    TimerListProvider timerListProvider,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value * 0.3, // Fade-in effect
                    child: Transform.scale(
                      scale: 1 + value * 0.3, // Scale up slightly
                      child: Container(
                        padding: const EdgeInsets.all(60),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Icon(Icons.timer, size: 80),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Time to get started!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            'No timers set yet. Create timers for your activities and track your time effectively.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              context.pushTransition(
                type: PageTransitionType.bottomToTop,
                child: const AddTimerPage(),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Create Your First Timer'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(BuildContext context, TimerModel timer) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Timer'),
          content: const Text('Are you sure to remove Timer?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<TimerListProvider>(
                  context,
                  listen: false,
                ).removeTimer(timer);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void showUpdateTargetDialog(BuildContext context, TimerModel timer) {
    final TextEditingController targetController = TextEditingController(
      text: timer.target?.inMinutes.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Target'),
          content: TextField(
            controller: targetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'New Target (Minutes)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newTargetMinutes = int.tryParse(targetController.text);
                if (newTargetMinutes != null) {
                  Provider.of<TimerListProvider>(
                    context,
                    listen: false,
                  ).updateTimer(
                    timer.copyWith(target: Duration(minutes: newTargetMinutes)),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
