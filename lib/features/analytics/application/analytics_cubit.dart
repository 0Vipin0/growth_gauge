import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/daily_workout_summary.dart';
import '../domain/exercise_set_metric.dart';
import '../domain/muscle_volume_stat.dart';
import '../domain/personal_record.dart';
import 'analytics_queries.dart';

class AnalyticsState extends Equatable {
  final bool isLoading;
  final List<DailyWorkoutSummary> history;
  final List<MuscleVolumeStat> weeklyVolume;
  final List<PersonalRecord> personalRecords;
  final List<ExerciseSetMetric> exerciseProgression;
  final String? selectedExerciseId;
  final String? errorMessage;

  const AnalyticsState({
    this.isLoading = false,
    this.history = const [],
    this.weeklyVolume = const [],
    this.personalRecords = const [],
    this.exerciseProgression = const [],
    this.selectedExerciseId,
    this.errorMessage,
  });

  AnalyticsState copyWith({
    bool? isLoading,
    List<DailyWorkoutSummary>? history,
    List<MuscleVolumeStat>? weeklyVolume,
    List<PersonalRecord>? personalRecords,
    List<ExerciseSetMetric>? exerciseProgression,
    String? selectedExerciseId,
    String? errorMessage,
  }) {
    return AnalyticsState(
      isLoading: isLoading ?? this.isLoading,
      history: history ?? this.history,
      weeklyVolume: weeklyVolume ?? this.weeklyVolume,
      personalRecords: personalRecords ?? this.personalRecords,
      exerciseProgression: exerciseProgression ?? this.exerciseProgression,
      selectedExerciseId: selectedExerciseId ?? this.selectedExerciseId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    history,
    weeklyVolume,
    personalRecords,
    exerciseProgression,
    selectedExerciseId,
    errorMessage,
  ];
}

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsQueries _queries;
  final String _userId;

  StreamSubscription<List<DailyWorkoutSummary>>? _historySub;
  StreamSubscription<List<MuscleVolumeStat>>? _volumeSub;
  StreamSubscription<List<PersonalRecord>>? _prSub;
  StreamSubscription<List<ExerciseSetMetric>>? _progressionSub;

  AnalyticsCubit({required this._queries, this._userId = 'local-user'})
    : super(const AnalyticsState()) {
    _initStreams();
  }

  void _initStreams() {
    emit(state.copyWith(isLoading: true));

    _historySub = _queries
        .watchWorkoutHistory(_userId)
        .listen(
          (history) => emit(state.copyWith(history: history, isLoading: false)),
          onError: (e) => emit(
            state.copyWith(errorMessage: e.toString(), isLoading: false),
          ),
        );

    _volumeSub = _queries
        .watchWeeklyMuscleVolume(_userId)
        .listen(
          (volume) => emit(state.copyWith(weeklyVolume: volume)),
          onError: (e) => emit(state.copyWith(errorMessage: e.toString())),
        );

    _prSub = _queries
        .watchAllPersonalRecords(_userId)
        .listen(
          (prs) => emit(state.copyWith(personalRecords: prs)),
          onError: (e) => emit(state.copyWith(errorMessage: e.toString())),
        );
  }

  void selectExercise(String exerciseId) {
    _progressionSub?.cancel();
    emit(state.copyWith(selectedExerciseId: exerciseId));

    _progressionSub = _queries
        .watchExerciseProgression(_userId, exerciseId)
        .listen(
          (progression) =>
              emit(state.copyWith(exerciseProgression: progression)),
          onError: (e) => emit(state.copyWith(errorMessage: e.toString())),
        );
  }

  Future<void> triggerRebuild() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _queries.rebuildAnalytics();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _historySub?.cancel();
    _volumeSub?.cancel();
    _prSub?.cancel();
    _progressionSub?.cancel();
    return super.close();
  }
}
