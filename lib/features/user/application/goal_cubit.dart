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

class GoalCubit({
  required final UserUseCases _useCases,
  final String _userId = 'local-user',
}) extends Cubit<GoalState> {
  StreamSubscription<List<TrainingGoal>>? _subscription;

  this : super(const GoalState()) {
    _initStream();
  }

  void _initStream() {
    emit(state.copyWith(isLoading: true));
    _subscription = _useCases
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
    final result = await _useCases.createGoal(
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
    final result = await _useCases.updateGoalProgress(goalId, newValue);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> completeGoal(String goalId) async {
    final result = await _useCases.completeGoal(goalId);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> abandonGoal(String goalId) async {
    final result = await _useCases.abandonGoal(goalId);
    if (result.isError) {
      emit(state.copyWith(errorMessage: result.errorOrNull!.message));
    }
  }

  Future<void> deleteGoal(String goalId) async {
    final result = await _useCases.deleteGoal(goalId);
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
