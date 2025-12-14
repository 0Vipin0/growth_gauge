import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/workout/services/flutter_tts_service.dart';
import 'package:growth_gauge/features/workout/services/tts_service.dart';

void main() {
  test('FlutterTtsService implements TtsService', () {
    final s = FlutterTtsService();
    expect(s, isA<TtsService>());
  });
}
