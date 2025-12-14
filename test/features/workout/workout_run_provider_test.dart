import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/workout_template.dart';
import 'package:growth_gauge/data/services/tts_service.dart';
import 'package:growth_gauge/ui/workout/provider/workout_run_provider.dart';

class FakeTts implements TtsService {
  final List<String> calls = [];
  @override
  Future<void> speak(String text) async {
    calls.add(text);
  }
}

void main() {
  test('WorkoutRunProvider pause/resume and tts', () async {
    final fakeTts = FakeTts();
    final provider = WorkoutRunProvider(ttsService: fakeTts);
    final t = WorkoutTemplate(name: 'TimerTest', steps: [
      {'name': 'Hold', 'duration': 3}
    ]);

    provider.startSession(t);
    expect(provider.template!.name, 'TimerTest');
    expect(fakeTts.calls.isNotEmpty, true);

    await Future.delayed(const Duration(milliseconds: 100));
    provider.pause();
    final pausedRem = provider.remaining;
    await Future.delayed(const Duration(seconds: 1));
    expect(provider.remaining, pausedRem);

    provider.resume();
    await Future.delayed(const Duration(seconds: 1));
    expect(provider.remaining, lessThanOrEqualTo(pausedRem! - 1));
  });

  test('WorkoutRunProvider handles sets progression', () {
    final provider = WorkoutRunProvider();
    final t = WorkoutTemplate(name: 'SetsTest', steps: [
      {'name': 'Sets', 'sets': 2, 'reps': 5}
    ]);

    provider.startSession(t);
    expect(provider.currentSetIndex, 0);

    provider.completeSet();
    expect(provider.currentSetIndex, 1);

    provider.completeSet();
    // After last set, next() should move to next step (none) so index remains
    expect(provider.currentIndex, 0);
  });
}
