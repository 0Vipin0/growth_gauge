import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'add_counter_page.dart';
import 'model/model.dart';
import 'provider/provider.dart';
import 'reusable_counter_widget.dart';

class CounterListWidget extends StatelessWidget {
  const CounterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterListProvider = Provider.of<CounterListProvider>(context);
    final List<String> selectedTags = []; // Track selected tags for filtering

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counters'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Sort by Name') {
                counterListProvider.sortCountersByName();
              } else if (value == 'Sort by Count') {
                counterListProvider.sortCountersByCount();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Sort by Name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'Sort by Count',
                child: Text('Sort by Count'),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (tag) {
              if (selectedTags.contains(tag)) {
                selectedTags.remove(tag);
              } else {
                selectedTags.add(tag);
              }
              counterListProvider.filterCountersByTags(selectedTags);
            },
            itemBuilder: (context) {
              return counterListProvider.getAllTags().map((tag) {
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
                          counterListProvider
                              .filterCountersByTags(selectedTags);
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
      body: counterListProvider.filteredCounters.isEmpty
          ? _buildEmptyCounterList(context)
          : ListView.builder(
              itemCount: counterListProvider.filteredCounters.length,
              itemBuilder: (context, index) {
                final counter = counterListProvider.filteredCounters[index];
                return ReusableCounterWidget(
                  counterModel: counter,
                  onRemove: () => showDeleteDialog(context, counter),
                  onUpdateTarget: () =>
                      showUpdateTargetDialog(context, counter),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushTransition(
            type: PageTransitionType.bottomToTop,
            child: const AddCounterPage(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyCounterList(BuildContext context) {
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
              const Icon(Icons.playlist_add_check, size: 80),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Ready to count things?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            'No counters created yet. Start tracking anything you want by creating your first counter.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              context.pushTransition(
                type: PageTransitionType.bottomToTop,
                child: const AddCounterPage(),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Your First Counter'),
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

  void showDeleteDialog(BuildContext context, CounterModel counter) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Counter'),
          content: const Text('Are you sure to remove Counter?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<CounterListProvider>(
                  context,
                  listen: false,
                ).removeCounter(counter);
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

  void showUpdateTargetDialog(BuildContext context, CounterModel counter) {
    final TextEditingController targetController = TextEditingController(
      text: counter.target?.toString() ?? '',
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
              labelText: 'New Target',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newTarget = int.tryParse(targetController.text);
                if (newTarget != null) {
                  Provider.of<CounterListProvider>(
                    context,
                    listen: false,
                  ).updateCounter(
                    counter.copyWith(target: newTarget),
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
