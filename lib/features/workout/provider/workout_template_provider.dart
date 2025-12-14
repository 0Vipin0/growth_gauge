import 'package:flutter/foundation.dart';

import '../../workout/model/workout_template.dart';
import '../../../data/repositories/workout_repository.dart';

class WorkoutTemplateProvider with ChangeNotifier {
  final WorkoutRepository? repository;

  WorkoutTemplateProvider({this.repository});

  final List<WorkoutTemplate> _templates = [];
  List<WorkoutTemplate> get templates => List.unmodifiable(_templates);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadTemplates() async {
    _isLoading = true;
    notifyListeners();

    if (repository != null) {
      final l = await repository!.loadTemplates();
      _templates.clear();
      _templates.addAll(l);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTemplate(WorkoutTemplate t) async {
    _templates.add(t);
    notifyListeners();
    if (repository != null) await repository!.saveTemplate(t);
  }

  Future<void> deleteTemplate(String id) async {
    _templates.removeWhere((t) => t.id == id);
    notifyListeners();
    if (repository != null) await repository!.deleteTemplate(id);
  }
}
