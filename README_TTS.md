# TTS Integration

This project supports Text-To-Speech (TTS) guidance during workouts.

- The `TtsService` abstraction is in `lib/features/workout/services/tts_service.dart`.
- A Flutter implementation `FlutterTtsService` uses the `flutter_tts` package.
- To enable/disable TTS cues, go to **Settings → TTS Cues (Voice Guidance)**.

## Platform Support

The TTS feature is supported on the following platforms:
- **Android**: Full support with INTERNET permission added to AndroidManifest.xml
- **iOS**: Full support
- **macOS**: Full support
- **Web**: Full support
- **Windows**: Not supported by flutter_tts package - falls back to silent operation
- **Linux**: Not supported by flutter_tts package - falls back to silent operation

## Platform-Specific Setup

### Android
- Added `android.permission.INTERNET` permission in `android/app/src/main/AndroidManifest.xml`
- This is required for some TTS engines used by flutter_tts

### Windows
- flutter_tts does not support Windows platform
- The `FlutterTtsService` automatically detects unsupported platforms and operates silently
- No TTS audio will be produced on Windows, but the app will continue to function normally

Notes for mobile platforms:
- `flutter_tts` requires platform-specific permissions; add any required Android/iOS permissions as described in the plugin README.
- Tests use `NoOpTtsService` or mocked `TtsService` to avoid platform calls.
