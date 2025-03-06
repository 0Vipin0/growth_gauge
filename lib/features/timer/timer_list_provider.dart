import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'timer_model.dart';
import 'timer_repository.dart';

class TimerListProvider with ChangeNotifier {
  final TimerRepository repository;
  List<TimerModel> _timers = [];
  final Uuid _uuid = const Uuid();

  TimerListProvider({required this.repository}) {
    _loadTimers();
  }

  List<TimerModel> get timers => _timers;

  Future<void> _loadTimers() async {
    _timers = await repository.getTimers();
    notifyListeners();
  }

  Future<void> saveTimers() async {
    await repository.saveTimers(_timers);
  }

  void addTimer() {
    final newTimer = TimerModel(
      id: _uuid.v4(),
      interval: Duration.zero,
      name: 'New Timer',
      description: 'New Timer',
      logs: [],
    );
    _timers.add(newTimer);
    saveTimers();
    notifyListeners();
  }

  void removeTimer(TimerModel timer) {
    _timers.remove(timer);
    saveTimers();
    notifyListeners();
  }

  Future<void> exportTimers() async {
    final String timersJson =
        json.encode(_timers.map((timer) => timer.toJson()).toList());
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/timers.json');
    await file.writeAsString(timersJson);
  }

  Future<void> importTimers() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final timersJson = await file.readAsString();
      final List<dynamic> timersList = json.decode(timersJson);
      _timers = timersList
          .map((timer) => TimerModel.fromJson(timer as Map<String, dynamic>))
          .toList();
      saveTimers();
      notifyListeners();
    }
  }
}
