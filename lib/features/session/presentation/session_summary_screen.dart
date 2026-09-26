import 'package:flutter/material.dart';

import '../domain/workout_session.dart';

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({super.key, required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final completedSets = session.blocks
        .expand((block) => block.items)
        .expand((item) => item.sets)
        .where((set) => set.status.name == 'completed')
        .length;
    final skippedSets = session.blocks
        .expand((block) => block.items)
        .expand((item) => item.sets)
        .where((set) => set.status.name == 'skipped')
        .length;
    final wall = session.completedAt == null || session.startedAt == null
        ? 0
        : session.completedAt!.difference(session.startedAt!).inSeconds;
    return Scaffold(
      appBar: AppBar(title: const Text('Workout summary')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.celebration_outlined, size: 64),
            const SizedBox(height: 16),
            Text(session.templateName,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Text('$completedSets sets completed · $skippedSets skipped'),
            Text('Elapsed time: ${Duration(seconds: wall).inMinutes} min'),
            const SizedBox(height: 24),
            FilledButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Done')),
          ]),
        ),
      ),
    );
  }
}
