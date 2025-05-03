import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'counter_details_page.dart';
import 'model/model.dart';
import 'provider/provider.dart';

class ReusableCounterWidget extends StatelessWidget {
  final CounterModel counterModel;
  final VoidCallback onRemove;
  final VoidCallback onUpdateTarget;

  const ReusableCounterWidget({
    super.key,
    required this.counterModel,
    required this.onRemove,
    required this.onUpdateTarget,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReusableCounterProvider(counter: counterModel),
      child: Consumer<ReusableCounterProvider>(
        builder: (context, counterProvider, child) {
          return Card(
            child: ListTile(
              title: Text(
                counterModel.name,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Count: ${counterProvider.count}',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelLarge?.fontSize,
                      )),
                  if (counterModel.target != null)
                    Text('Target: ${counterModel.target}',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelMedium?.fontSize,
                          color: Colors.green,
                        )),
                  if (counterModel.target == null)
                    TextButton(
                      onPressed: onUpdateTarget,
                      child: const Text('Add Target',
                          style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: counterModel.tags
                            ?.map((tag) => Chip(label: Text(tag)))
                            .toList() ??
                        [],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: _buildAction(counterProvider, context),
              ),
              onTap: () {
                context.pushTransition(
                  type: PageTransitionType.bottomToTop,
                  child: CounterDetailsPage(counter: counterModel),
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildAction(
    ReusableCounterProvider counterProvider,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Widget> actions = [
      IconButton(
        icon: const Icon(Icons.remove),
        tooltip: 'Decrease',
        onPressed: () {
          counterProvider.decreaseCounter();
          Provider.of<CounterListProvider>(context, listen: false)
              .updateCounter(counterProvider.counter);
        },
      ),
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Increase',
        onPressed: () {
          counterProvider.increaseCounter();
          Provider.of<CounterListProvider>(context, listen: false)
              .updateCounter(counterProvider.counter);
        },
      ),
    ];
    if (screenWidth > kDesktopScreenSize) {
      if (counterModel.target != null) {
        actions.add(
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Update Target',
            onPressed: onUpdateTarget,
          ),
        );
      }
      actions.add(
        IconButton(
          icon: const Icon(Icons.label),
          tooltip: 'Manage Tags',
          onPressed: () {
            _manageTagsDialog(context);
          },
        ),
      );
      actions.add(
        IconButton(
          icon: const Icon(Icons.delete),
          tooltip: 'Delete',
          onPressed: onRemove,
        ),
      );
    } else {
      actions.add(
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'UpdateTargetAction') {
              onUpdateTarget();
            } else if (value == 'ManageTagsAction') {
              _manageTagsDialog(context);
            } else if (value == 'DeleteAction') {
              onRemove();
            }
          },
          itemBuilder: (context) => [
            if (counterModel.target != null)
              const PopupMenuItem(
                value: 'UpdateTargetAction',
                child: Text('Update Target'),
              ),
            const PopupMenuItem(
              value: 'ManageTagsAction',
              child: Text('Manage Tags'),
            ),
            const PopupMenuItem(
              value: 'DeleteAction',
              child: Text('Delete'),
            ),
          ],
        ),
      );
    }

    return actions;
  }

  void _manageTagsDialog(BuildContext context) {
    final counterProvider =
        Provider.of<CounterListProvider>(context, listen: false);
    counterProvider.initializeTags(counterModel.tags);

    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController tagController = TextEditingController();

        return AlertDialog(
          title: const Text('Manage Tags'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  labelText: 'Add Tag',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    counterProvider.addTag(value);
                    tagController.clear();
                  }
                },
              ),
              const SizedBox(height: 8),
              Consumer<CounterListProvider>(
                builder: (context, provider, child) {
                  return Wrap(
                    spacing: 8.0,
                    children: provider.updatedTags
                        .map((tag) => Chip(
                              label: Text(tag),
                              onDeleted: () {
                                provider.removeTag(tag);
                              },
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                counterProvider.saveTags(counterModel);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
