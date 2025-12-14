import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'tts_service.dart';

class FlutterTtsService implements TtsService {
  final FlutterTts? _tts;
  final bool _isSupported;

  FlutterTtsService() : _isSupported = _checkPlatformSupport() {
    if (_isSupported) {
      _tts = FlutterTts();
      _tts!.setSharedInstance(true);
      _tts!.setSpeechRate(0.5);
      _tts!.setVolume(1.0);
      _tts!.setPitch(1.0);
    } else {
      _tts = null;
    }
  }

  static bool _checkPlatformSupport() {
    // flutter_tts supports Android, iOS, Web, macOS
    // Windows and Linux are not supported
    return Platform.isAndroid || Platform.isIOS || Platform.isMacOS || kIsWeb;
  }

  @override
  Future<void> speak(String text) async {
    if (_isSupported && _tts != null) {
      await _tts!.speak(text);
    }
    // On unsupported platforms, silently do nothing
  }
}
