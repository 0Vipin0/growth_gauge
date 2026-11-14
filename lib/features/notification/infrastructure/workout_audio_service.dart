import 'package:flutter/services.dart';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';

class WorkoutAudioService({
  var bool soundEnabled = true,
  var bool vibrationEnabled = true,
}) {
  final AudioPlayer _audioPlayer = AudioPlayer();
  this {
    // Ensure media_kit initializes audio backend implementation for desktop/windows targets
    JustAudioMediaKit.ensureInitialized();
  }

  /// Plays an open-source audio cue for rest completion or milestones
  Future<void> playRestCompleteCue() async {
    if (vibrationEnabled) {
      await HapticFeedback.heavyImpact();
    }

    if (!soundEnabled) return;

    try {
      // Using an open-source bundled asset or fallback sound URI
      await _audioPlayer.setAsset('assets/audio/simple_notification.mp3');
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      // Graceful silent fallback if asset loading fails
    }
  }

  /// Plays a lighter cue for set logging or intermediate milestones
  Future<void> playMilestoneCue() async {
    if (vibrationEnabled) {
      await HapticFeedback.mediumImpact();
    }

    if (!soundEnabled) return;

    try {
      await _audioPlayer.setAsset('assets/audio/milestone.mp3');
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      // Graceful fallback
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
