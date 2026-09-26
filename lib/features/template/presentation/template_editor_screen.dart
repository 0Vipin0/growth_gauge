import 'package:flutter/material.dart';

import '../../../core/ids/unique_id.dart';
import '../application/template_use_cases.dart';
import '../domain/template_enums.dart';
import '../domain/workout_block.dart';
import '../domain/workout_template_revision.dart';
import '../infrastructure/template_repository.dart';

class TemplateEditorScreen extends StatefulWidget {
  const TemplateEditorScreen(
      {super.key,
      required this.revision,
      required this.repository,
      required this.useCases,
      required this.userId});
  final WorkoutTemplateRevision revision;
  final ITemplateRepository repository;
  final TemplateUseCases useCases;
  final String userId;

  @override
  State<TemplateEditorScreen> createState() => _TemplateEditorScreenState();
}

class _TemplateEditorScreenState extends State<TemplateEditorScreen> {
  late List<WorkoutBlock> _blocks;
  bool _saving = false;
  @override
  void initState() {
    super.initState();
    _blocks = [...widget.revision.blocks];
  }

  Future<void> _addBlock() async {
    final name =
        TextEditingController(text: 'Workout block ${_blocks.length + 1}');
    final value = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add block'),
              content: TextField(
                  controller: name,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Block name')),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => Navigator.pop(context, name.text),
                    child: const Text('Add'))
              ],
            ));
    name.dispose();
    if (value == null || value.trim().isEmpty) return;
    setState(() => _blocks
        .add(WorkoutBlock(id: UniqueId.generate().value, name: value.trim())));
  }

  Future<void> _save({bool publish = false}) async {
    setState(() => _saving = true);
    final result =
        await widget.useCases.updateDraftBlocks(widget.revision.id, _blocks);
    if (result.isError) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result.errorOrNull!.message)));
      }
      return;
    }
    if (publish) {
      final published = await widget.useCases.publish(widget.revision.id);
      if (published.isError) {
        if (mounted) {
          setState(() => _saving = false);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(published.errorOrNull!.message)));
        }
        return;
      }
    }
    if (mounted) {
      setState(() => _saving = false);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Edit revision ${widget.revision.revisionNumber}')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _addBlock,
            icon: const Icon(Icons.add),
            label: const Text('Add block')),
        bottomNavigationBar: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: _saving ? null : () => _save(),
                          child: const Text('Save draft'))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: FilledButton(
                          onPressed:
                              _saving ? null : () => _save(publish: true),
                          child:
                              Text(_saving ? 'Saving…' : 'Publish revision'))),
                ]))),
        body: _blocks.isEmpty
            ? const Center(child: Text('Add a block to organise this workout'))
            : ReorderableListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _blocks.length,
                onReorder: (oldIndex, newIndex) => setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final block = _blocks.removeAt(oldIndex);
                  _blocks.insert(newIndex, block);
                }),
                itemBuilder: (context, index) {
                  final block = _blocks[index];
                  return Card(
                      key: ValueKey(block.id),
                      child: ListTile(
                        leading: const Icon(Icons.drag_handle),
                        title: Text(block.name),
                        subtitle: const Text('No exercises added'),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () =>
                                setState(() => _blocks.removeAt(index))),
                      ));
                },
              ),
      );
}
