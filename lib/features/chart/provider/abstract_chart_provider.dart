import 'package:flutter/foundation.dart';

abstract class AbstractChartProvider<T> extends ChangeNotifier {
  /// Processes the data for the chart based on the provided model.
  List<dynamic> processDataForChart(T model);

  /// Gets the day of the week for a given index.
  String getDayOfWeek(int index);
}
