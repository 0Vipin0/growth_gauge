import 'package:intl/intl.dart';

import 'timer_model.dart';

class FlatTimerModel({
  required final String id,
  required final String name,
  required final Duration interval,
  required final String description,
  required final String target,
  required final String logAction,
  required final DateTime logTimestamp,
  required final Duration logInterval,
}) {
  factory fromTimerModel(TimerModel timerModel, TimerLog timerLog) {
    return FlatTimerModel(
      id: timerModel.id,
      name: timerModel.name,
      interval: timerModel.interval,
      description: timerModel.description,
      target: timerModel.target?.inSeconds.toString() ?? '0',
      logAction: timerLog.action,
      logTimestamp: timerLog.timestamp,
      logInterval: timerLog.interval,
    );
  }

  List<dynamic> toCsvRow() {
    return [
      id,
      name,
      interval.inSeconds,
      description,
      target,
      logAction,
      DateFormat('dd-MM-yyyy HH:mm:ss').format(logTimestamp),
      logInterval.inSeconds,
    ];
  }
}
