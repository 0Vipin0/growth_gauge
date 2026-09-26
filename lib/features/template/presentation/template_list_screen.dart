import 'package:flutter/material.dart';

import '../application/template_use_cases.dart';
import '../domain/workout_template.dart';
import '../infrastructure/template_repository.dart';
import 'template_detail_screen.dart';

class TemplateListScreen extends StatefulWidget {
  const TemplateListScreen(
      {super.key,
      required this.repository,
      required this.useCases,
      required this.userId});
  final ITemplateRepository repository;
  final TemplateUseCases useCases;
  final String userId;

  @override
  State<TemplateListScreen> createState() => _TemplateListScreenState();
}

class _TemplateListScreenState extends State<TemplateListScreen> {
  late Stream<List<WorkoutTemplate>> _templates;

  @override
  void initState() {
    super.initState();
    _templates = widget.repository.watchTemplates();
  }

  Future<void> _create() async {
    final name = TextEditingController();
    final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('New workout template'),
              content: TextField(
                  controller: name,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Name')),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => Navigator.pop(context, name.text),
                    child: const Text('Create'))
              ],
            ));
    name.dispose();
    if (result == null || !mounted) return;
    final created =
        await widget.useCases.create(name: result, createdById: widget.userId);
    if (created.isError && mounted)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(created.errorOrNull!.message)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Workout templates')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _create,
            icon: const Icon(Icons.add),
            label: const Text('New template')),
        body: StreamBuilder<List<WorkoutTemplate>>(
          stream: _templates,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Center(child: Text('Could not load templates'));
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());
            final templates =
                snapshot.data!.where((t) => !t.isArchived).toList();
            if (templates.isEmpty)
              return const Center(
                  child: Text('Create a template to start planning workouts'));
            return ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, i) {
                  final template = templates[i];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.view_agenda)),
                    title: Text(template.name),
                    subtitle: Text(template.description.isEmpty
                        ? 'No description'
                        : template.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TemplateDetailScreen(
                            template: template,
                            repository: widget.repository,
                            useCases: widget.useCases,
                            userId: widget.userId))),
                  );
                });
          },
        ),
      );
}
