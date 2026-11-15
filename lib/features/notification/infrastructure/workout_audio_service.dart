import 'dart:io';

import 'package:flutter/services.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:path_provider/path_provider.dart';

class WorkoutAudioService({
  var bool soundEnabled = true,
  var bool vibrationEnabled = true,
}) {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _cachedRestCompletePath;
  String? _cachedMilestonePath;

  this {
    JustAudioMediaKit.ensureInitialized();
    _initializeAssetFiles();
  }

  Future<void> _initializeAssetFiles() async {
    try {
      _cachedRestCompletePath = await _loadAssetToFile(
        'assets/sounds/simple_notification.mp3',
        'simple_notification.mp3',
      );
      _cachedMilestonePath = await _loadAssetToFile(
        'assets/sounds/milestone.mp3',
        'milestone.mp3',
      );
    } catch (e) {
      // Fallback handling
    }
  }

  Future<String> _loadAssetToFile(String assetPath, String fileName) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    return file.path;
  }

  Future<void> playRestCompleteCue() async {
    if (vibrationEnabled) {
      await HapticFeedback.heavyImpact();
    }

    if (!soundEnabled) return;

    try {
      final path =
          _cachedRestCompletePath ??
          await _loadAssetToFile(
            Assets.sounds.notification.regular,
            'regular.mp3',
          );

      // Use AudioSource.file to prevent MPV from trying to create a streaming file cache
      await _audioPlayer.setAudioSource(AudioSource.file(path));
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      // Handle playback error
    }
  }

  Future<void> playMilestoneCue() async {
    if (vibrationEnabled) {
      await HapticFeedback.mediumImpact();
    }

    if (!soundEnabled) return;

    try {
      final path =
          _cachedMilestonePath ??
          await _loadAssetToFile(Assets.sounds.whistle.long, 'long.mp3');
      await _audioPlayer.setAudioSource(AudioSource.file(path));
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {}
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
