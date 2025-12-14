import 'package:growth_gauge/data/models/models.dart';
import 'package:intl/intl.dart';

class FlatTimerModel {
  FlatTimerModel({
    required this.id,
    required this.name,
    required this.interval,
    required this.description,
    required this.target,
    required this.logAction,
    required this.logTimestamp,
    required this.logInterval,
  });

  final String id;
  final String name;
  final Duration interval;
  final String description;
  final String target;
  final String logAction;
  final DateTime logTimestamp;
  final Duration logInterval;

  factory FlatTimerModel.fromTimerModel(
    TimerModel timerModel,
    TimerLog timerLog,
  ) {
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
