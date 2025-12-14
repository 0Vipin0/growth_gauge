# TTS Integration

This project supports Text-To-Speech (TTS) guidance during workouts.

- The `TtsService` abstraction is in `lib/features/workout/services/tts_service.dart`.
- A Flutter implementation `FlutterTtsService` uses the `flutter_tts` package.
- To enable/disable TTS cues, go to **Settings → TTS Cues (Voice Guidance)**.

Notes for mobile platforms:
- `flutter_tts` requires platform-specific permissions; add any required Android/iOS permissions as described in the plugin README.
- Tests use `NoOpTtsService` or mocked `TtsService` to avoid platform calls.
