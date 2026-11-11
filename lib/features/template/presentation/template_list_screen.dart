import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../catalog/infrastructure/exercise_repository.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../../session/application/session_use_cases.dart';
import '../../session/domain/session_enums.dart';
import '../../session/infrastructure/session_repository.dart';
import '../../session/presentation/screen/session_recovery_dialog.dart';
import '../application/template_use_cases.dart';
import '../domain/workout_template.dart';
import '../infrastructure/template_repository.dart';

class const TemplateListScreen({
  super.key,
  required final ITemplateRepository repository,
  required final IExerciseRepository exerciseRepository,
  required final IWorkoutSessionRepository sessionRepository,
  required final SessionUseCases sessionUseCases,
  required final TemplateUseCases useCases,
  required final String userId,
}) extends StatefulWidget {
  @override
  State<TemplateListScreen> createState() => _TemplateListScreenState();
}

class _TemplateListScreenState() extends State<TemplateListScreen> {
  late Stream<List<WorkoutTemplate>> _templates;
  bool _showArchived = false;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _templates = widget.repository.watchTemplates();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerRecovery());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _offerRecovery() async {
    final result = await widget.sessionRepository.listUnfinished(widget.userId);
    if (!mounted || result.isError || result.dataOrNull!.isEmpty) return;
    final sessions = result.dataOrNull!;
    final selected = await showSessionRecoveryDialog(context, sessions);
    if (selected == null || !mounted) {
      return;
    }
    var session = selected;
    final recovered = await widget.sessionUseCases.recoverIncomplete(
      session.id,
    );
    if (recovered.isError) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(recovered.errorOrNull!.message)));
      }
      return;
    }
    session = recovered.dataOrNull!;
    if (session.status == SessionStatus.completed) {
      return;
    }
    if (!mounted) {
      return;
    }
    await context.push(appRouteActiveSession, extra: session);
  }

  Future<void> _create() async {
    final nameController = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New workout template'),
        content: SizedBox(
          width: 400,
          child: AppTextField(
            controller: nameController,
            label: 'Name',
            hintText: 'Enter template name...',
            prefixIcon: Icons.view_agenda_outlined,
          ),
        ),
        actions: [
          AppButton.ghost(
            label: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          AppButton.primary(
            label: 'Create',
            onPressed: () => Navigator.pop(context, nameController.text),
          ),
        ],
      ),
    );
    nameController.dispose();
    if (result == null || result.trim().isEmpty || !mounted) return;
    final created = await widget.useCases.create(
      name: result,
      createdById: widget.userId,
    );
    if (created.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(created.errorOrNull!.message)));
    }
  }

  Future<void> _toggleArchive(WorkoutTemplate template) async {
    final result = await widget.useCases.archiveTemplate(
      template.id,
      isArchived: !template.isArchived,
    );
    if (result.isError && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
    }
  }

  Future<void> _confirmAndDelete(WorkoutTemplate template) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permanently delete template?'),
        content: Text('This action cannot be undone for "${template.name}".'),
        actions: [
          AppButton.ghost(
            label: 'Cancel',
            onPressed: () => Navigator.pop(context, false),
          ),
          AppButton.primary(
            label: 'Delete',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      final result = await widget.useCases.deleteTemplate(template.id);
      if (result.isError && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      }
    }
  }

  void _clearFilters() {
    setState(() {
      _query = '';
      _searchController.clear();
      _showArchived = false;
      _selectedTag = null;
    });
  }

  bool get _hasActiveFilters =>
      _query.isNotEmpty || _showArchived || _selectedTag != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Workout templates'), centerTitle: true),
      floatingActionButton: _showArchived
          ? null
          : FloatingActionButton.extended(
              onPressed: _create,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              icon: const Icon(Icons.add),
              label: const Text('New template'),
            ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                // Search Bar with functional clear suffix unit
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: AppTextField(
                    controller: _searchController,
                    label: 'Search templates...',
                    hintText: 'Type to search templates...',
                    prefixIcon: Icons.search,
                    suffixUnit: _query.isNotEmpty ? 'CLEAR' : null,
                    onSuffixTap: () => setState(() {
                      _query = '';
                      _searchController.clear();
                    }),
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),

                // StreamBuilder to fetch and gather available unique tags dynamically
                Expanded(
                  child: StreamBuilder<List<WorkoutTemplate>>(
                    stream: _templates,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Could not load templates'),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final allTemplates = snapshot.data!;

                      // Extract all unique tags across all templates
                      final availableTags = allTemplates
                          .expand((t) => t.tags)
                          .toSet()
                          .toList();

                      // Filter templates based on archive flag, search query, and selected tag
                      final templates = allTemplates.where((t) {
                        final matchesArchive = t.isArchived == _showArchived;
                        final matchesQuery =
                            _query.isEmpty ||
                            t.name.toLowerCase().contains(
                              _query.toLowerCase(),
                            ) ||
                            t.description.toLowerCase().contains(
                              _query.toLowerCase(),
                            );
                        final matchesTag =
                            _selectedTag == null ||
                            t.tags.contains(_selectedTag);
                        return matchesArchive && matchesQuery && matchesTag;
                      }).toList();

                      return Column(
                        children: [
                          // Filter Chips Row (Active/Archived + Dynamic Tags)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  if (_hasActiveFilters) ...[
                                    ActionChip(
                                      avatar: const Icon(
                                        Icons.filter_alt_off,
                                        size: 16,
                                      ),
                                      label: const Text('Clear All'),
                                      onPressed: _clearFilters,
                                      backgroundColor:
                                          colorScheme.errorContainer,
                                      labelStyle: TextStyle(
                                        color: colorScheme.onErrorContainer,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  // Status Filter Chip (Active vs Archived)
                                  FilterChip(
                                    avatar: Icon(
                                      _showArchived
                                          ? Icons.archive
                                          : Icons.check,
                                      size: 18,
                                      color: _showArchived
                                          ? colorScheme.onPrimaryContainer
                                          : colorScheme.onSurfaceVariant,
                                    ),
                                    label: Text(
                                      _showArchived
                                          ? 'Status: Archived'
                                          : 'Status: Active',
                                    ),
                                    selected: _showArchived,
                                    onSelected: (selected) => setState(
                                      () => _showArchived = selected,
                                    ),
                                    backgroundColor:
                                        colorScheme.surfaceContainerHighest,
                                    selectedColor: colorScheme.primaryContainer,
                                    labelStyle: TextStyle(
                                      color: _showArchived
                                          ? colorScheme.onPrimaryContainer
                                          : colorScheme.onSurface,
                                      fontWeight: _showArchived
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  if (availableTags.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    // Tag Filter Dropdown/Popup Button
                                    PopupMenuButton<String?>(
                                      initialValue: _selectedTag,
                                      onSelected: (tag) =>
                                          setState(() => _selectedTag = tag),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem<String?>(
                                          child: Text(
                                            'Any tag',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const PopupMenuDivider(),
                                        ...availableTags.map(
                                          (tag) => PopupMenuItem<String?>(
                                            value: tag,
                                            child: Text(tag),
                                          ),
                                        ),
                                      ],
                                      child: Chip(
                                        avatar: Icon(
                                          _selectedTag != null
                                              ? Icons.check
                                              : Icons.arrow_drop_down,
                                          size: 18,
                                          color: _selectedTag != null
                                              ? colorScheme.onPrimaryContainer
                                              : colorScheme.onSurfaceVariant,
                                        ),
                                        label: Text(
                                          _selectedTag != null
                                              ? 'Tag: $_selectedTag'
                                              : 'Tag: Any',
                                        ),
                                        backgroundColor: _selectedTag != null
                                            ? colorScheme.primaryContainer
                                            : colorScheme
                                                  .surfaceContainerHighest,
                                        labelStyle: TextStyle(
                                          color: _selectedTag != null
                                              ? colorScheme.onPrimaryContainer
                                              : colorScheme.onSurface,
                                          fontWeight: _selectedTag != null
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Expanded(
                            child: templates.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          _showArchived
                                              ? Icons.archive_outlined
                                              : Icons.view_agenda_outlined,
                                          size: 64,
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          _showArchived
                                              ? 'No archived templates found'
                                              : 'No templates match your search',
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth >= 900 ? 32 : 20,
                                      vertical: 8,
                                    ),
                                    itemCount: templates.length,
                                    separatorBuilder: (_, _) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, i) {
                                      final template = templates[i];
                                      return AppCard(
                                        onTap: () => context.push(
                                          appRouteTemplateDetail,
                                          extra: template,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: colorScheme
                                                    .primaryContainer
                                                    .withValues(alpha: 0.3),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Icon(
                                                _showArchived
                                                    ? Icons.archive
                                                    : Icons.view_agenda,
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    template.name,
                                                    style: theme
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: colorScheme
                                                              .onSurface,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    template.description.isEmpty
                                                        ? 'No description'
                                                        : template.description,
                                                    style: theme
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color: colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PopupMenuButton<String>(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                              onSelected: (value) {
                                                if (value == 'archive') {
                                                  _toggleArchive(template);
                                                } else if (value == 'delete') {
                                                  _confirmAndDelete(template);
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 'archive',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        template.isArchived
                                                            ? Icons.unarchive
                                                            : Icons.archive,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        template.isArchived
                                                            ? 'Restore'
                                                            : 'Archive',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete_forever,
                                                        size: 18,
                                                        color:
                                                            colorScheme.error,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Delete permanently',
                                                        style: TextStyle(
                                                          color:
                                                              colorScheme.error,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
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
}
