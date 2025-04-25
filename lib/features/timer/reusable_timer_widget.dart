import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';
import 'provider/provider.dart';
import 'timer_details_page.dart';

class ReusableTimerWidget extends StatelessWidget {
  final TimerModel timerModel;
  final VoidCallback onRemove;

  const ReusableTimerWidget({
    super.key,
    required this.timerModel,
    required this.onRemove,
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
                  title: Text(timerModel.description),
                  subtitle: Text(
                    'Time Passed: ${timerProvider.currentInterval.inSeconds} seconds\n',
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
