import 'package:intl/intl.dart';

import 'counter_model.dart';

class FlatCounterModel {
  final String counterId;
  final String counterName;
  final int counterCount;
  final String counterDescription;
  final String logId;
  final String logAction;
  final DateTime logTimestamp;

  FlatCounterModel({
    required this.counterId,
    required this.counterName,
    required this.counterCount,
    required this.counterDescription,
    required this.logId,
    required this.logAction,
    required this.logTimestamp,
  });

  static FlatCounterModel fromCounterModel(
      CounterModel counter, CounterLog log) {
    return FlatCounterModel(
      counterId: counter.id,
      counterName: counter.name,
      counterCount: counter.count,
      counterDescription: counter.description,
      logId: log.id,
      logAction: log.action,
      logTimestamp: log.timestamp,
    );
  }

  List<dynamic> toCsvRow() {
    return [
      counterId,
      counterName,
      counterCount,
      counterDescription,
      logId,
      logAction,
      DateFormat('dd-MM-yyyy HH:mm:ss').format(logTimestamp),
    ];
  }
}
