import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/workout_run_provider.dart';

class WorkoutRunPage extends StatelessWidget {
  const WorkoutRunPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutRunProvider>(context);
    final step = provider.currentStep;

    if (provider.template == null) {
      return Scaffold(appBar: AppBar(title: const Text('Workout')), body: const Center(child: Text('No workout running')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(provider.template!.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step ${provider.currentIndex + 1}/${provider.template!.steps.length}', style: Theme.of(context).textTheme.titleMedium),
                if (provider.isPaused)
                  ElevatedButton.icon(onPressed: provider.resume, icon: const Icon(Icons.play_arrow), label: const Text('Resume'))
                else
                  ElevatedButton.icon(onPressed: provider.pause, icon: const Icon(Icons.pause), label: const Text('Pause'))
              ],
            ),
            const SizedBox(height: 8),
            Text(step?['name'] ?? 'Untitled', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            if (step != null && step.containsKey('duration'))
              Center(child: Text('${provider.remaining ?? 0}s', style: Theme.of(context).textTheme.headlineSmall)),
            if (step != null && step.containsKey('reps')) Center(child: Text('${step['reps']} reps', style: Theme.of(context).textTheme.headlineSmall)),
            if (step != null && step.containsKey('sets'))
              Column(children: [
                Text('Set ${provider.currentSetIndex + 1}/${step['sets']}', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: provider.completeSet, child: const Text('Complete Set'))
              ]),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(onPressed: provider.prev, icon: const Icon(Icons.chevron_left), label: const Text('Prev')),
                ElevatedButton.icon(onPressed: provider.stop, icon: const Icon(Icons.stop), label: const Text('Stop')),
                ElevatedButton.icon(onPressed: provider.next, icon: const Icon(Icons.chevron_right), label: const Text('Next')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
