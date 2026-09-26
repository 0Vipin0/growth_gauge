import 'package:flutter/material.dart';

import '../application/catalog_use_cases.dart';
import '../domain/exercise.dart';
import '../infrastructure/exercise_repository.dart';
import 'custom_exercise_screen.dart';
import 'exercise_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.repository, required this.useCases, required this.userId});
  final IExerciseRepository repository;
  final CatalogUseCases useCases;
  final String userId;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<List<Exercise>> _exercises;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _exercises = widget.useCases.list(query: _query).then((r) => r.dataOrNull ?? const []);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Exercise catalog')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final created = await Navigator.of(context).push<bool>(MaterialPageRoute(
              builder: (_) => CustomExerciseScreen(useCases: widget.useCases, userId: widget.userId),
            ));
            if (created == true && mounted) setState(_load);
          },
          icon: const Icon(Icons.add), label: const Text('Custom exercise'),
        ),
        body: Column(children: [
          Padding(padding: const EdgeInsets.all(16), child: TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: 'Search exercises', border: OutlineInputBorder()),
            onChanged: (value) => setState(() { _query = value; _load(); }),
          )),
          Expanded(child: FutureBuilder<List<Exercise>>(
            future: _exercises,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              if (snapshot.data!.isEmpty) return const Center(child: Text('No exercises found'));
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final exercise = snapshot.data![index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.fitness_center)),
                    title: Text(exercise.name),
                    subtitle: Text(exercise.classification.movementPatterns.map((e) => e.name).join(' · ')),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: exercise))),
                  );
                },
              );
            },
          )),
        ]),
      );
}
