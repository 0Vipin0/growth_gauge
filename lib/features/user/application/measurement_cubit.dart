import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/user_enums.dart';
import '../domain/user_measurement.dart';
import 'user_use_cases.dart';

class const MeasurementState({
  final bool isLoading = false,
  final List<UserMeasurement> measurements = const [],
  final MeasurementType? selectedType,
  final String? errorMessage,
}) extends Equatable {
  List<UserMeasurement> get filteredMeasurements => selectedType == null
      ? measurements
      : measurements.where((m) => m.type == selectedType).toList();

  UserMeasurement? get latestMeasurement =>
      filteredMeasurements.isEmpty ? null : filteredMeasurements.first;

  static const Object _sentinel = Object();

  MeasurementState copyWith({
    bool? isLoading,
    List<UserMeasurement>? measurements,
    Object? selectedType = _sentinel,
    String? errorMessage,
  }) {
    return MeasurementState(
      isLoading: isLoading ?? this.isLoading,
      measurements: measurements ?? this.measurements,
      selectedType: identical(selectedType, _sentinel)
          ? this.selectedType
          : selectedType as MeasurementType?,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    measurements,
    selectedType,
    errorMessage,
  ];
}

class MeasurementCubit({
  required final UserUseCases _useCases,
  final String _userId = 'local-user',
}) extends Cubit<MeasurementState> {
  StreamSubscription<List<UserMeasurement>>? _subscription;

  this : super(const MeasurementState()) {
    _initStream();
  }

  void _initStream() {
    emit(state.copyWith(isLoading: true));
    _subscription = _useCases
        .watchMeasurements(_userId)
        .listen(
          (measurements) {
            emit(state.copyWith(measurements: measurements, isLoading: false));
          },
          onError: (e) {
            emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
          },
        );
  }

  void selectType(MeasurementType? type) {
    emit(state.copyWith(selectedType: type));
  }

  Future<void> logMeasurement({
    required MeasurementType type,
    required double value,
    required String unit,
    DateTime? recordedAt,
    String? notes,
  }) async {
    final result = await _useCases.logMeasurement(
      userId: _userId,
      type: type,
      value: value,
      unit: unit,
      recordedAt: recordedAt,
      notes: notes,
    );
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
