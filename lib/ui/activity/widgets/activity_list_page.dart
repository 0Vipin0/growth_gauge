import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:provider/provider.dart';

import '../provider/activity_provider.dart';

class ActivityListWidget extends StatefulWidget {
  const ActivityListWidget({super.key});

  @override
  State<ActivityListWidget> createState() => _ActivityListWidgetState();
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  String _query = '';

  Future<void> _showCreateDialog(BuildContext context) async {
    final nameCtrl = TextEditingController();
    final unitCtrl = TextEditingController(text: 'reps');
    ActivityType type = ActivityType.countBased;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name')),
              TextField(
                  controller: unitCtrl,
                  decoration: const InputDecoration(labelText: 'Unit')),
              const SizedBox(height: 8),
              DropdownButton<ActivityType>(
                value: type,
                items: ActivityType.values
                    .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => type = v ?? ActivityType.countBased),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.trim().isEmpty) return;
                final provider =
                    Provider.of<ActivityProvider>(context, listen: false);
                provider.addActivity(Activity(
                    name: nameCtrl.text.trim(),
                    type: type,
                    unit: unitCtrl.text.trim()));
                Navigator.pop(context, true);
              },
              child: const Text('Create'),
            )
          ],
        );
      },
    );

    if (result == true) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActivityProvider>(context);
    final activities = provider.activities
        .where((a) => a.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Activities')),
      body: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final content = activities.isEmpty
            ? const Center(child: Text('No activities yet'))
            : isWide
                ? GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 5),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final a = activities[index];
                      return Card(
                        child: ListTile(
                          title: Text(a.name),
                          subtitle: Text(a.unit),
                          trailing: IconButton(
                            icon: Icon(
                                a.isFavorite ? Icons.star : Icons.star_border),
                            onPressed: () {
                              final updated =
                                  a.copyWith(isFavorite: !a.isFavorite);
                              provider.addActivity(
                                  updated); // simple replace for now
                            },
                          ),
                          onTap: () => Navigator.pushNamed(
                              context, '/activity/detail',
                              arguments: a.id),
                        ),
                      );
                    },
                  )
                : ListView.separated(
                    itemCount: activities.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final a = activities[index];
                      return ListTile(
                        title: Text(a.name),
                        subtitle: Text(a.unit),
                        trailing: a.isFavorite ? const Icon(Icons.star) : null,
                        onTap: () => Navigator.pushNamed(
                            context, '/activity/detail',
                            arguments: a.id),
                      );
                    },
                  );

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search activities'),
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Expanded(child: content),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
