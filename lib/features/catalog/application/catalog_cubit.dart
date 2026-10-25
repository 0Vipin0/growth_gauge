import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/result.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import 'catalog_use_cases.dart';

class const CatalogState({
  final List<Exercise> exercises = const [],
  final bool isLoading = false,
  final String? failureMessage,
});

class CatalogCubit(final CatalogUseCases _useCases)
    extends Cubit<CatalogState> {
  this : super(const CatalogState());
  Future<void> load({
    String query = '',
    BodyRegion? bodyRegion,
    MovementPattern? movementPattern,
    MuscleGroup? muscleGroup,
    EquipmentType? equipment,
  }) async {
    emit(CatalogState(exercises: state.exercises, isLoading: true));
    final result = await _useCases.list(
      query: query,
      bodyRegion: bodyRegion,
      movementPattern: movementPattern,
      muscleGroup: muscleGroup,
      equipment: equipment,
    );
    switch (result) {
      case Success(data: final exercises):
        emit(CatalogState(exercises: exercises));
      case Error(:final failure):
        emit(
          CatalogState(
            exercises: state.exercises,
            failureMessage: failure.message,
          ),
        );
    }
  }
}
