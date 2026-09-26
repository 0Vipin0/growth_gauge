import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/result.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import 'catalog_use_cases.dart';

class CatalogState {
  const CatalogState({this.exercises = const [], this.isLoading = false, this.failureMessage});
  final List<Exercise> exercises;
  final bool isLoading;
  final String? failureMessage;
}

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._useCases) : super(const CatalogState());
  final CatalogUseCases _useCases;

  Future<void> load({String query = '', BodyRegion? bodyRegion, MovementPattern? movementPattern, EquipmentType? equipment}) async {
    emit(CatalogState(exercises: state.exercises, isLoading: true));
    final result = await _useCases.list(query: query, bodyRegion: bodyRegion, movementPattern: movementPattern, equipment: equipment);
    switch (result) {
      case Success(data: final exercises):
        emit(CatalogState(exercises: exercises));
        break;
      case Error(failure: final failure):
        emit(CatalogState(exercises: state.exercises, failureMessage: failure.message));
        break;
    }
  }
}
