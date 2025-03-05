import 'package:flutter/material.dart';
import 'add_counter_page.dart';
import 'package:provider/provider.dart';
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
      body: ListView.builder(
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
}
