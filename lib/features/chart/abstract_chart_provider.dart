import 'package:fl_chart/fl_chart.dart';

abstract class AbstractChartProvider<T> {
  /// Processes the data for the chart based on the provided model.
  List<dynamic> processDataForChart(T model);

  /// Generates bar groups for the chart.
  List<BarChartGroupData> generateBarGroups(
    Map<String, dynamic> processedData,
    DateTime startDate,
    DateTime endDate,
  );

  /// Gets the day of the week for a given index.
  String getDayOfWeek(int index);
}
