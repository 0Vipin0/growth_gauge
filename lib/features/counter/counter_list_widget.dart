import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () async {
              String jsonString = ''; // Replace with your file picker result
              await counterListProvider.importCounters(jsonString);
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await counterListProvider.exportCounters();
            },
          ),
        ],
      ),
      body: counterListProvider.counters.isEmpty
          ? _buildEmptyCounterList(context) // Show empty state widget
          : ListView.builder(
              itemCount: counterListProvider.counters.length,
              itemBuilder: (context, index) {
                final counter = counterListProvider.counters[index];
                return ReusableCounterWidget(
                  counterModel: counter,
                  onRemove: () => showDeleteDialog(context, counter),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddCounterPage(),
            ),
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
              const Icon(
                Icons.playlist_add_check,
                size: 80,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Ready to count things?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'No counters created yet. Start tracking anything you want by creating your first counter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCounterPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Your First Counter'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  showDeleteDialog(BuildContext context, CounterModel counter) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Counter'),
          content: const Text('Are you sure to remove Counter?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<CounterListProvider>(context, listen: false)
                    .removeCounter(counter);
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
}
