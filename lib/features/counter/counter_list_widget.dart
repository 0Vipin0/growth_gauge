import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'add_counter_page.dart';
import 'model/model.dart';
import 'provider/provider.dart';
import 'reusable_counter_widget.dart';

class CounterListWidget extends StatelessWidget {
  const CounterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterListProvider = Provider.of<CounterListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Counters'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'SortByNameAsc') {
                counterListProvider.sortCountersByName(ascending: true);
              } else if (value == 'SortByNameDesc') {
                counterListProvider.sortCountersByName(ascending: false);
              } else if (value == 'SortByCountAsc') {
                counterListProvider.sortCountersByCount(ascending: true);
              } else if (value == 'SortByCountDesc') {
                counterListProvider.sortCountersByCount(ascending: false);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'SortByNameAsc',
                child: Text('Sort by Name (Asc)'),
              ),
              const PopupMenuItem(
                value: 'SortByNameDesc',
                child: Text('Sort by Name (Desc)'),
              ),
              const PopupMenuItem(
                value: 'SortByCountAsc',
                child: Text('Sort by Count (Asc)'),
              ),
              const PopupMenuItem(
                value: 'SortByCountDesc',
                child: Text('Sort by Count (Desc)'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > kTabletScreenSize) {
                return Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Filter Counters:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: _buildFilterTextField(counterListProvider),
                    ),
                  ],
                );
              } else {
                return _buildFilterTextField(counterListProvider);
              }
            },
          ),
          _buildFilterTags(counterListProvider),
          const SizedBox(height: 8),
          Expanded(
            child: counterListProvider.filteredCounters.isEmpty
                ? _buildEmptyCounterList(context)
                : ListView.builder(
                    itemCount: counterListProvider.filteredCounters.length,
                    itemBuilder: (context, index) {
                      final counter =
                          counterListProvider.filteredCounters[index];
                      return ReusableCounterWidget(
                        counterModel: counter,
                        onRemove: () => showDeleteDialog(context, counter),
                        onUpdateTarget: () =>
                            showUpdateTargetDialog(context, counter),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Counter',
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

  Widget _buildFilterTags(CounterListProvider counterListProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        children: [
          if (counterListProvider.selectedTags.isNotEmpty)
            ChoiceChip(
              label: const Text('Clear All'),
              selected: false,
              onSelected: (_) {
                counterListProvider.clearSelectedTags();
              },
            ),
          ...counterListProvider.getAllTags().map((tag) {
            final isSelected = counterListProvider.selectedTags.contains(tag);
            return ChoiceChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (_) {
                counterListProvider.toggleTagSelection(tag);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterTextField(CounterListProvider counterListProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search Counters',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        onChanged: (value) {
          counterListProvider.filterCountersByText(value);
        },
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
