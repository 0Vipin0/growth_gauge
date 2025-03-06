import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'add_timer_page.dart';
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
      body: timerListProvider.timers.isEmpty
          ? _buildEmptyTimerList(
              context, timerListProvider) // Show empty state widget
          : ListView.builder(
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTimerPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyTimerList(
      BuildContext context, TimerListProvider timerListProvider) {
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
                          color: Colors.orange.shade100,
                          // Soft orange background
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Icon(
                Icons.timer,
                size: 80,
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Time to get started!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'No timers set yet. Create timers for your activities and track your time effectively.',
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
                  builder: (context) => const AddTimerPage(),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Create Your First Timer'),
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
}
