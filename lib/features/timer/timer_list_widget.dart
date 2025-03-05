import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_timer.dart';
import 'timer_list_provider.dart';

class TimerListWidget extends StatelessWidget {
  const TimerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerListProvider = Provider.of<TimerListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await timerListProvider.exportTimers();
              if (messenger.mounted) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Timers exported successfully')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await timerListProvider.importTimers();
              if (messenger.mounted) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Timers imported successfully')),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: timerListProvider.timers.length,
        itemBuilder: (context, index) {
          final timer = timerListProvider.timers[index];
          return ReusableTimer(
            timerModel: timer,
            onRemove: () => timerListProvider.removeTimer(timer),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: timerListProvider.addTimer,
        child: const Icon(Icons.add),
      ),
    );
  }
}
