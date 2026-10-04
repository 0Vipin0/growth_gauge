import 'package:intl/intl.dart';

import 'counter_model.dart';

class FlatCounterModel({
  required final String counterId,
  required final String counterName,
  required final int counterCount,
  required final String counterDescription,
  required final int target,
  required final String logId,
  required final String logAction,
  required final DateTime logTimestamp,
}) {
  static FlatCounterModel fromCounterModel(
    CounterModel counter,
    CounterLog log,
  ) {
    return FlatCounterModel(
      counterId: counter.id,
      counterName: counter.name,
      counterCount: counter.count,
      counterDescription: counter.description,
      target: counter.target ?? 0,
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
      target,
      logId,
      logAction,
      DateFormat('dd-MM-yyyy HH:mm:ss').format(logTimestamp),
    ];
  }
}
