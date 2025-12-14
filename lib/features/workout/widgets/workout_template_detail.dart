import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/workout_template.dart';
import '../provider/workout_template_provider.dart';
import '../../workout/provider/workout_run_provider.dart';
import '../../workout/widgets/workout_run_page.dart';

class WorkoutTemplateDetailPage extends StatelessWidget {
  final String templateId;

  const WorkoutTemplateDetailPage({super.key, required this.templateId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutTemplateProvider>(context);
    final template = provider.templates.firstWhere((t) => t.id == templateId, orElse: () => throw Exception('Template not found'));

    return Scaffold(
      appBar: AppBar(title: Text(template.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (template.description != null) Text(template.description!),
            const SizedBox(height: 12),
            const Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: template.steps.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final step = template.steps[index];
                  return ListTile(
                    title: Text(step['name'] ?? 'Step ${index + 1}'),
                    subtitle: Text(_stepSubtitle(step)),
                    leading: CircleAvatar(child: Text('${index + 1}')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start'),
        onPressed: () {
          // start workout run session
          final runProvider = Provider.of<WorkoutRunProvider>(context, listen: false);
          runProvider.startSession(template);
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(value: runProvider, child: const WorkoutRunPage())));
        },
      ),
    );
  }

  String _stepSubtitle(Map<String, dynamic> step) {
    if (step.containsKey('duration')) return '${step['duration']} sec';
    if (step.containsKey('reps')) return '${step['reps']} reps';
    return '';
  }
}
