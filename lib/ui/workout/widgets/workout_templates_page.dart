import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:growth_gauge/data/models/models.dart';
import '../provider/workout_template_provider.dart';
import 'workout_template_detail.dart';

class WorkoutTemplatesPage extends StatelessWidget {
  const WorkoutTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutTemplateProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Templates')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (provider.isLoading) const LinearProgressIndicator(),
            if (provider.templates.isEmpty)
              const Center(child: Text('No workout templates yet'))
            else
              Expanded(
                child: ListView.separated(
                  itemCount: provider.templates.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final t = provider.templates[index];
                    return ListTile(
                      title: Text(t.name),
                      subtitle:
                          t.description == null ? null : Text(t.description!),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => provider.deleteTemplate(t.id)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => WorkoutTemplateDetailPage(
                                    templateId: t.id)));
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final nameCtl = TextEditingController();
          final descCtl = TextEditingController();

          final ok = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('New Template'),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextField(
                        controller: nameCtl,
                        decoration: const InputDecoration(labelText: 'Name')),
                    TextField(
                        controller: descCtl,
                        decoration:
                            const InputDecoration(labelText: 'Description'))
                  ]),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Create'))
                  ],
                );
              });

          if (ok == true && nameCtl.text.trim().isNotEmpty) {
            final t = WorkoutTemplate(
                name: nameCtl.text.trim(),
                description:
                    descCtl.text.trim().isEmpty ? null : descCtl.text.trim());
            await provider.addTemplate(t);
          }
        },
      ),
    );
  }
}
