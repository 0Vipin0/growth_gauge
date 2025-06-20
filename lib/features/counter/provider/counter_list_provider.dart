import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../notification/notification_service.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class CounterListProvider with ChangeNotifier {
  final CounterRepository repository;
  final NotificationService notificationService;
  List<CounterModel> _counters = [];

  CounterListProvider(
      {required this.repository, required this.notificationService}) {
    _loadCounters();
  }

  List<CounterModel> get counters => _counters;

  Future<void> _loadCounters() async {
    _counters = await repository.loadCounters();
    notifyListeners();
  }

  Future<void> saveCounters() async {
    await repository.saveCounters(_counters);
  }

  Future<void> clearCounters() async {
    _counters = [];
    saveCounters();
    notifyListeners();
  }

  void addCounter(CounterModel newCounter) {
    _counters.add(newCounter);
    saveCounters();
    notifyListeners();
  }

  CounterModel getCounter(CounterModel newCounter) {
    return _counters.firstWhere((counter) => counter.id == newCounter.id);
  }

  void updateCounter(CounterModel newCounter) {
    CounterModel counter = getCounter(newCounter);
    if (newCounter.target != null && newCounter.target != counter.target) {
      final log = CounterLog(
        id: DateTime.now().toIso8601String(),
        action: 'Target updated to ${newCounter.target}',
        timestamp: DateTime.now(),
      );
      final modifiableLogs = List<CounterLog>.from(counter.logs);
      modifiableLogs.add(log);
      final updatedCounter = counter.copyWith(logs: modifiableLogs);
      for (int i = 0; i < _counters.length; i++) {
        if (updatedCounter.id == _counters[i].id) {
          _counters[i] = updatedCounter;
        }
      }
    }

    counter = getCounter(newCounter).copyWith(
      count: newCounter.count,
      target: newCounter.target ?? counter.target,
      logs: newCounter.logs,
      tags: newCounter.tags,
    );

    for (int i = 0; i < _counters.length; i++) {
      if (counter.id == _counters[i].id) {
        _counters[i] = counter;
      }
    }

    // Check if the target is reached
    if (counter.target != null && counter.count >= counter.target!) {
      // Trigger notification
      _triggerNotification(
        title: 'Target Reached!',
        body:
            'Counter "${counter.name}" has reached its target of ${counter.target}.',
      );
    }

    saveCounters();
    notifyListeners();
  }

  void _triggerNotification({required String title, required String body}) {
    notificationService.scheduleNotification(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: title,
        body: body,
        scheduledTime:
            tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        sound: 'assets/sounds/simple_notification.mp3');
  }

  void removeCounter(CounterModel counter) {
    _counters.remove(counter);
    saveCounters();
    notifyListeners();
  }

  void importCountersFromData(List<CounterModel> importedCounters) {
    _counters = importedCounters;
    saveCounters();
    notifyListeners();
  }

  Map<DateTime, int> extractCountsByDay(CounterModel counter) {
    final Map<DateTime, int> countsByDay = {};

    final List<CounterLog> countLog = getCounter(counter).logs;
    for (int j = 0; j < countLog.length; j++) {
      final dateTime = countLog[j].timestamp;
      final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
      countsByDay.update(
        dateOnly,
        (existingCount) => existingCount + 1,
        ifAbsent: () => 1,
      );
    }

    return countsByDay;
  }

  String convertToCSV() {
    final List<FlatCounterModel> flattenedDataList = [];
    for (final CounterModel counter in _counters) {
      for (final CounterLog log in counter.logs) {
        flattenedDataList.add(FlatCounterModel.fromCounterModel(counter, log));
      }
    }
    return convertFlattenedListToCsv(flattenedDataList);
  }

  String convertFlattenedListToCsv(List<FlatCounterModel> flattenedDataList) {
    final List<List<dynamic>> rows = [];

    rows.add([
      'ID',
      'Name',
      'Count',
      'Description',
      'Target',
      'Log ID',
      'Log Action',
      'Log Timestamp',
    ]);

    for (final FlatCounterModel flattenedData in flattenedDataList) {
      rows.add(flattenedData.toCsvRow());
    }

    return const ListToCsvConverter().convert(rows);
  }

  List<CounterModel> _filteredCounters = [];

  List<CounterModel> get filteredCounters =>
      _filteredCounters.isEmpty ? _counters : _filteredCounters;

  void filterCountersByTags(List<String> tags) {
    if (tags.isEmpty) {
      _filteredCounters = [];
    } else {
      _filteredCounters = _counters
          .where((counter) =>
              counter.tags != null &&
              counter.tags!.any((tag) => tags.contains(tag)))
          .toList();
    }
    notifyListeners();
  }

  void filterCountersByText(String query) {
    if (query.isEmpty) {
      _filteredCounters = [];
    } else {
      _filteredCounters = _counters.where((counter) {
        final lowerQuery = query.toLowerCase();
        return counter.name.toLowerCase().contains(lowerQuery) ||
            counter.description.toLowerCase().contains(lowerQuery) ||
            (counter.target?.toString().contains(lowerQuery) ?? false) ||
            counter.count.toString().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  List<String> getAllTags() {
    final Set<String> tags = {};
    for (final counter in _counters) {
      if (counter.tags != null) {
        tags.addAll(counter.tags!);
      }
    }
    return tags.toList();
  }

  void sortCountersByName() {
    _counters.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortCountersByCount() {
    _counters.sort((a, b) => a.count.compareTo(b.count));
    notifyListeners();
  }

  final List<String> _selectedTags = [];

  List<String> get selectedTags => _selectedTags;

  void toggleTagSelection(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      _selectedTags.add(tag);
    }
    filterCountersByTags(_selectedTags);
    notifyListeners();
  }

  void clearSelectedTags() {
    _selectedTags.clear();
    filterCountersByTags(_selectedTags);
    notifyListeners();
  }

  void addTagToCounter(CounterModel counter, String tag) {
    if (!counter.tags!.contains(tag)) {
      final updatedTags = List<String>.from(counter.tags ?? [])..add(tag);
      updateCounter(counter.copyWith(tags: updatedTags));
    }
  }

  void removeTagFromCounter(CounterModel counter, String tag) {
    final updatedTags = List<String>.from(counter.tags ?? [])..remove(tag);
    updateCounter(counter.copyWith(tags: updatedTags));
  }

  void updateTagsForCounter(CounterModel counter, List<String> updatedTags) {
    updateCounter(counter.copyWith(tags: updatedTags));
  }

  List<String> _updatedTags = [];

  List<String> get updatedTags => _updatedTags;

  void initializeTags(List<String>? tags) {
    _updatedTags = List<String>.from(tags ?? []);
    notifyListeners();
  }

  void addTag(String tag) {
    if (!_updatedTags.contains(tag)) {
      _updatedTags.add(tag);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    _updatedTags.remove(tag);
    notifyListeners();
  }

  void saveTags(CounterModel counter) {
    final CounterModel updatedCounter = counter.copyWith(tags: _updatedTags);
    updateCounter(updatedCounter);
    _updatedTags = [];
    notifyListeners();
  }
}
