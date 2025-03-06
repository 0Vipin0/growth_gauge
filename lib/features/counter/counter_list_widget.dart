import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'add_counter_page.dart';
import 'counter_list_provider.dart';
import 'reusable_counter.dart';

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
        // Show list if not empty
        itemCount: counterListProvider.counters.length,
        itemBuilder: (context, index) {
          final counter = counterListProvider.counters[index];
          return ReusableCounter(
            counterModel: counter,
            onRemove: () => counterListProvider.removeCounter(counter),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.playlist_add_check,
              size: 80,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No counters yet!',
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Get started by creating your first counter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCounterPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Counter'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      ),
    );
  }
}
