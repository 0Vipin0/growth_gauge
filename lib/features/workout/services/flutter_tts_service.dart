import 'package:flutter_tts/flutter_tts.dart';

import 'tts_service.dart';

class FlutterTtsService implements TtsService {
  final FlutterTts _tts = FlutterTts();

  FlutterTtsService() {
    _tts.setSharedInstance(true);
    _tts.setSpeechRate(0.5);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);
  }

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }
}
