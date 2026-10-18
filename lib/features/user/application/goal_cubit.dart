import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/training_goal.dart';
import '../domain/user_enums.dart';
import 'user_use_cases.dart';

class const GoalState({
  final bool isLoading = false,
  final List<TrainingGoal> goals = const [],
  final String? errorMessage,
}) extends Equatable {
  List<TrainingGoal> get activeGoals =>
      goals.where((g) => g.status == GoalStatus.active).toList();

  List<TrainingGoal> get achievedGoals =>
      goals.where((g) => g.status == GoalStatus.achieved).toList();

  GoalState copyWith({
    bool? isLoading,
    List<TrainingGoal>? goals,
    String? errorMessage,
  }) {
    return GoalState(
      isLoading: isLoading ?? this.isLoading,
      goals: goals ?? this.goals,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, goals, errorMessage];
}

class GoalCubit extends Cubit<GoalState> {
  final UserUseCases? _useCases;
  final String _userId;
  StreamSubscription<List<TrainingGoal>>? _subscription;

  // ignore: unnecessary_type_name_in_constructor
  GoalCubit({required this._useCases, this._userId = 'local-user'})
    : super(const GoalState()) {
    _initStream();
  }

  /// Creates a preloaded cubit for presentation tests without a data stream.
  // ignore: unnecessary_type_name_in_constructor
  GoalCubit.seeded(super.seed) : _useCases = null, _userId = '';

  void _initStream() {
    emit(state.copyWith(isLoading: true));
    _subscription = _useCases!
        .watchGoals(_userId)
        .listen(
          (goals) {
            emit(state.copyWith(goals: goals, isLoading: false));
          },
          onError: (e) {
            emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
          },
        );
  }

  Future<void> createGoal({
    required GoalType type,
    required String name,
    String description = '',
    required double startValue,
    required double targetValue,
    String unit = 'kg',
    DateTime? targetDate,
  }) async {
    final useCases = _useCases;
    if (useCases == null) return;
    final result = await useCases.createGoal(
      userId: _userId,
      type: type,
      name: name,
      description: description,
      startValue: startValue,
      targetValue: targetValue,
      unit: unit,
      targetDate: targetDate,
    );
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> updateProgress(String goalId, double newValue) async {
    final useCases = _useCases;
    if (useCases == null) return;
    final result = await useCases.updateGoalProgress(goalId, newValue);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> completeGoal(String goalId) async {
    final useCases = _useCases;
    if (useCases == null) return;
    final result = await useCases.completeGoal(goalId);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> abandonGoal(String goalId) async {
    final useCases = _useCases;
    if (useCases == null) return;
    final result = await useCases.abandonGoal(goalId);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> deleteGoal(String goalId) async {
    final useCases = _useCases;
    if (useCases == null) return;
    final result = await useCases.deleteGoal(goalId);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
