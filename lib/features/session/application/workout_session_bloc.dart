import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/workout_session.dart';

class const WorkoutSessionState({
  required final WorkoutSession session,
  final bool isBusy = false,
}) extends Equatable {
  WorkoutSessionState copyWith({WorkoutSession? session, bool? isBusy}) =>
      WorkoutSessionState(
        session: session ?? this.session,
        isBusy: isBusy ?? this.isBusy,
      );

  @override
  List<Object?> get props => [session, isBusy];
}

/// Owns the live session snapshot while serializing user commands.
class WorkoutSessionBloc({required WorkoutSession initialSession})
    extends Cubit<WorkoutSessionState> {
  this : super(WorkoutSessionState(session: initialSession));

  Future<Result<WorkoutSession, Failure>?> execute(
    Future<Result<WorkoutSession, Failure>> Function() command,
  ) async {
    if (isClosed || state.isBusy) return null;
    emit(state.copyWith(isBusy: true));
    try {
      final result = await command();
      if (!isClosed) {
        emit(state.copyWith(session: result.dataOrNull, isBusy: false));
      }
      return result;
    } catch (error) {
      if (!isClosed) emit(state.copyWith(isBusy: false));
      return Result.error(DatabaseFailure('Session command failed', error));
    }
  }
}
