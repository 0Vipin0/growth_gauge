abstract class TtsService {
  Future<void> speak(String text);
}

class NoOpTtsService implements TtsService {
  @override
  Future<void> speak(String text) async {}
}
