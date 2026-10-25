import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../application/catalog_use_cases.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import '../infrastructure/exercise_repository.dart';

class const CatalogScreen({
  super.key,
  required final IExerciseRepository repository,
  required final CatalogUseCases useCases,
  required final String userId,
}) extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState() extends State<CatalogScreen> {
  late Future<List<Exercise>> _exercises;
  String _query = '';
  BodyRegion? _bodyRegion;
  MovementPattern? _movementPattern;
  MuscleGroup? _muscleGroup;
  EquipmentType? _equipment;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _exercises = widget.useCases
        .list(
          query: _query,
          bodyRegion: _bodyRegion,
          movementPattern: _movementPattern,
          muscleGroup: _muscleGroup,
          equipment: _equipment,
        )
        .then((r) => r.dataOrNull ?? const []);
  }

  void _clearFilters() {
    setState(() {
      _query = '';
      _bodyRegion = null;
      _movementPattern = null;
      _muscleGroup = null;
      _equipment = null;
      _load();
    });
  }

  bool get _hasActiveFilters =>
      _bodyRegion != null ||
      _movementPattern != null ||
      _muscleGroup != null ||
      _equipment != null ||
      _query.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Exercise catalog'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.push<bool>(appRouteCustomExercise);
          if (created == true && mounted) setState(_load);
        },
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Custom exercise'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: colorScheme.primary,
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _query = '';
                                  _load();
                                });
                              },
                            )
                          : null,
                      hintText: 'Search exercises...',
                      filled: true,
                      fillColor: colorScheme.surfaceContainer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => setState(() {
                      _query = value;
                      _load();
                    }),
                  ),
                ),

                // Filter Chips Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (_hasActiveFilters) ...[
                          ActionChip(
                            avatar: const Icon(Icons.filter_alt_off, size: 16),
                            label: const Text('Clear All'),
                            onPressed: _clearFilters,
                            backgroundColor: colorScheme.errorContainer,
                            labelStyle: TextStyle(
                              color: colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        _buildFilterChip<BodyRegion>(
                          title: 'Region',
                          value: _bodyRegion,
                          options: BodyRegion.values,
                          onSelected: (val) => setState(() {
                            _bodyRegion = val;
                            _load();
                          }),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip<MovementPattern>(
                          title: 'Pattern',
                          value: _movementPattern,
                          options: MovementPattern.values,
                          onSelected: (val) => setState(() {
                            _movementPattern = val;
                            _load();
                          }),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip<MuscleGroup>(
                          title: 'Muscle',
                          value: _muscleGroup,
                          options: MuscleGroup.values,
                          onSelected: (val) => setState(() {
                            _muscleGroup = val;
                            _load();
                          }),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip<EquipmentType>(
                          title: 'Equipment',
                          value: _equipment,
                          options: EquipmentType.values,
                          onSelected: (val) => setState(() {
                            _equipment = val;
                            _load();
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Exercise Results
                Expanded(
                  child: FutureBuilder<List<Exercise>>(
                    future: _exercises,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final exercises = snapshot.data!;
                      if (exercises.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fitness_center_outlined,
                                size: 64,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No exercises found',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // Responsive Grid vs List
                      if (screenWidth >= 900) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) =>
                              _buildExerciseCard(context, exercises[index]),
                        );
                      } else if (screenWidth >= 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.4,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) =>
                              _buildExerciseCard(context, exercises[index]),
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                          itemCount: exercises.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              _buildExerciseCard(context, exercises[index]),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip<T extends Enum>({
    required String title,
    required T? value,
    required List<T> options,
    required ValueChanged<T?> onSelected,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = value != null;

    return PopupMenuButton<T?>(
      initialValue: value,
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<T?>(
          child: Text(
            'Any $title',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const PopupMenuDivider(),
        ...options.map(
          (opt) => PopupMenuItem<T?>(value: opt, child: Text(opt.name)),
        ),
      ],
      child: Chip(
        avatar: Icon(
          isSelected ? Icons.check : Icons.arrow_drop_down,
          size: 18,
          color: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurfaceVariant,
        ),
        label: Text(isSelected ? '$title: ${value.name}' : 'Any $title'),
        backgroundColor: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(
          color: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, Exercise exercise) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final movement = exercise.classification.movementPatterns
        .map((e) => e.name)
        .join(' · ');

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(appRouteExerciseDetail, extra: exercise),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.fitness_center, color: colorScheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      exercise.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movement.isEmpty ? 'General' : movement,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
