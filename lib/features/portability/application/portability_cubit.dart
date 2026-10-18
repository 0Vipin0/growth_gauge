import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/conflict_strategy.dart';
import '../domain/import_report.dart';
import '../infrastructure/file_storage_service.dart';
import 'export_data_use_case.dart';
import 'import_data_use_case.dart';

class const PortabilityState({
  final bool isBusy = false,
  final String? message,
  final String? error,
  final ImportReport? report,
});

class PortabilityCubit({
  required final ExportDataUseCase exportData,
  required final ImportDataUseCase importData,
  required final FileStorageService fileStorage,
}) extends Cubit<PortabilityState> {
  final ExportDataUseCase _exportData = exportData;
  final ImportDataUseCase _importData = importData;
  final FileStorageService _fileStorage = fileStorage;

  this : super(const PortabilityState());

  Future<void> exportBackup() async {
    emit(const PortabilityState(isBusy: true));
    try {
      final envelope = await _exportData();
      final uri = await _fileStorage.saveJson(
        '${const JsonEncoder.withIndent('  ').convert(envelope.toJson())}\n',
      );
      emit(
        PortabilityState(
          message: uri == null ? 'Export cancelled.' : 'Backup saved.',
        ),
      );
    } catch (error) {
      emit(PortabilityState(error: 'Could not export backup: $error'));
    }
  }

  Future<void> importBackup(ConflictStrategy strategy) async {
    emit(const PortabilityState(isBusy: true));
    try {
      final json = await _fileStorage.pickJson();
      if (json == null) {
        emit(const PortabilityState(message: 'Import cancelled.'));
        return;
      }
      final report = await _importData(json, strategy: strategy);
      emit(PortabilityState(message: 'Import completed.', report: report));
    } catch (error) {
      emit(PortabilityState(error: 'Could not import backup: $error'));
    }
  }
}
