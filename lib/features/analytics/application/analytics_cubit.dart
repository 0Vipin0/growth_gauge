import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/daily_workout_summary.dart';
import '../domain/exercise_set_metric.dart';
import '../domain/muscle_volume_stat.dart';
import '../domain/personal_record.dart';
import 'analytics_queries.dart';

class const AnalyticsState({
  final bool isLoading = false,
  final List<DailyWorkoutSummary> history = const [],
  final List<MuscleVolumeStat> weeklyVolume = const [],
  final List<PersonalRecord> personalRecords = const [],
  final List<ExerciseSetMetric> exerciseProgression = const [],
  final String? selectedExerciseId,
  final String? errorMessage,
}) extends Equatable {
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

class AnalyticsCubit({
  required final AnalyticsQueries _queries,
  final String _userId = 'local-user',
}) extends Cubit<AnalyticsState> {
  StreamSubscription<List<DailyWorkoutSummary>>? _historySub;
  StreamSubscription<List<MuscleVolumeStat>>? _volumeSub;
  StreamSubscription<List<PersonalRecord>>? _prSub;
  StreamSubscription<List<ExerciseSetMetric>>? _progressionSub;
  late final Future<void> _initialization;
  bool _closing = false;

  this : super(const AnalyticsState()) {
    _initialization = _initStreams();
  }

  void _emitIfOpen(AnalyticsState nextState) {
    if (!_closing && !isClosed) emit(nextState);
  }

  Future<void> _initStreams() async {
    _emitIfOpen(state.copyWith(isLoading: true));

    try {
      // Rebuild projections on init so existing completed sessions populate analytics
      await _queries.rebuildAnalytics();
    } catch (e) {
      _emitIfOpen(state.copyWith(errorMessage: e.toString()));
    }

    // close() can be called while rebuilding. Do not attach new subscriptions
    // after teardown has started.
    if (_closing || isClosed) return;

    _historySub = _queries
        .watchWorkoutHistory(_userId)
        .listen(
          (history) =>
              _emitIfOpen(state.copyWith(history: history, isLoading: false)),
          onError: (e) => _emitIfOpen(
            state.copyWith(errorMessage: e.toString(), isLoading: false),
          ),
        );

    _volumeSub = _queries
        .watchWeeklyMuscleVolume(_userId)
        .listen(
          (volume) => _emitIfOpen(state.copyWith(weeklyVolume: volume)),
          onError: (e) =>
              _emitIfOpen(state.copyWith(errorMessage: e.toString())),
        );

    _prSub = _queries
        .watchAllPersonalRecords(_userId)
        .listen(
          (prs) => _emitIfOpen(state.copyWith(personalRecords: prs)),
          onError: (e) =>
              _emitIfOpen(state.copyWith(errorMessage: e.toString())),
        );
  }

  void selectExercise(String exerciseId) {
    if (_closing || isClosed) return;
    _progressionSub?.cancel();
    _emitIfOpen(state.copyWith(selectedExerciseId: exerciseId));

    _progressionSub = _queries
        .watchExerciseProgression(_userId, exerciseId)
        .listen(
          (progression) =>
              _emitIfOpen(state.copyWith(exerciseProgression: progression)),
          onError: (e) =>
              _emitIfOpen(state.copyWith(errorMessage: e.toString())),
        );
  }

  Future<void> triggerRebuild() async {
    if (_closing || isClosed) return;
    try {
      _emitIfOpen(state.copyWith(isLoading: true));
      await _queries.rebuildAnalytics();
      _emitIfOpen(state.copyWith(isLoading: false));
    } catch (e) {
      _emitIfOpen(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    _closing = true;
    await _cancelSubscriptions();
    await _initialization;
    await _cancelSubscriptions();
    await super.close();
  }

  Future<void> _cancelSubscriptions() async {
    await Future.wait([
      if (_historySub != null) _historySub!.cancel(),
      if (_volumeSub != null) _volumeSub!.cancel(),
      if (_prSub != null) _prSub!.cancel(),
      if (_progressionSub != null) _progressionSub!.cancel(),
    ]);
  }
}
