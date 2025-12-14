import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:growth_gauge/data/services/flutter_tts_service.dart';
import 'package:growth_gauge/data/services/tts_service.dart';

void main() {
  test('FlutterTtsService implements TtsService', () {
    final s = FlutterTtsService(FlutterTts());
    expect(s, isA<TtsService>());
  });
}
