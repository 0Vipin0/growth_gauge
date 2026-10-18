import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// Selects JSON backup files and writes portable archives using the platform
/// file picker, which also handles platforms that do not expose file paths.
class FileStorageService() {
  Future<String?> pickJson() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (files.isEmpty) return null;
    final bytes = await files.single.readAsBytes();
    return utf8.decode(bytes);
  }

  Future<Uri?> saveJson(
    String contents, {
    String fileName = 'growth-gauge-backup.json',
  }) => FilePicker.saveFile(
    dialogTitle: 'Save Growth Gauge backup',
    fileName: fileName,
    bytes: Uint8List.fromList(utf8.encode(contents)),
    mimeType: 'application/json',
  );
}
