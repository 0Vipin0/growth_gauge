import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'reusable_timer_provider.dart';
import 'timer_details_page.dart';
import 'timer_list_provider.dart';
import 'timer_model.dart';

class ReusableTimer extends StatelessWidget {
  final TimerModel timerModel;
  final VoidCallback onRemove;

  const ReusableTimer(
      {super.key, required this.timerModel, required this.onRemove});

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
                  title: Text(timerModel.description),
                  subtitle: Text(
                      'Time Passed: ${timerProvider.currentInterval.inSeconds} seconds\n'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(timerProvider.isRunning
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          timerProvider.startOrPauseTimer();
                          Provider.of<TimerListProvider>(context, listen: false)
                              .updateTimer(timerProvider.timer);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          timerProvider.resetTimer();
                          Provider.of<TimerListProvider>(context, listen: false)
                              .updateTimer(timerProvider.timer);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TimerDetailsPage(timer: timerModel),
                      ),
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
