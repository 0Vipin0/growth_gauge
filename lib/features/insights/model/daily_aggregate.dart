class DailyAggregate {
  final DateTime day;
  final double total;

  DailyAggregate({required this.day, required this.total});

  factory DailyAggregate.fromMap(Map<String, dynamic> m) {
    return DailyAggregate(day: DateTime.parse(m['day'] as String), total: (m['total'] as num).toDouble());
  }
}
