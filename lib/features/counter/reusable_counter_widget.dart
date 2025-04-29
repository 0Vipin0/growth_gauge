import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
              title: Text(counterModel.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Count: ${counterProvider.count}'),
                  if (counterModel.target != null)
                    Text('Target: ${counterModel.target}',
                        style: const TextStyle(color: Colors.green)),
                  if (counterModel.target == null)
                    TextButton(
                      onPressed: onUpdateTarget,
                      child: const Text('Add Target',
                          style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: counterModel.tags?.map((tag) => Chip(
                          label: Text(tag),
                        ))?.toList() ?? [],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      counterProvider.decreaseCounter();
                      Provider.of<CounterListProvider>(
                        context,
                        listen: false,
                      ).updateCounter(counterProvider.counter);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      counterProvider.increaseCounter();
                      Provider.of<CounterListProvider>(
                        context,
                        listen: false,
                      ).updateCounter(counterProvider.counter);
                    },
                  ),
                  if (counterModel.target != null)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onUpdateTarget,
                    ),
                  IconButton(
                    icon: const Icon(Icons.label),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController tagController = TextEditingController();
                          final List<String> updatedTags = List.from(counterModel.tags ?? []);

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
                                    if (value.isNotEmpty && !updatedTags.contains(value)) {
                                      updatedTags.add(value);
                                      tagController.clear();
                                    }
                                  },
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8.0,
                                  children: updatedTags.map((tag) => Chip(
                                        label: Text(tag),
                                        onDeleted: () {
                                          updatedTags.remove(tag);
                                        },
                                      )).toList(),
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
                                  Provider.of<CounterListProvider>(
                                    context,
                                    listen: false,
                                  ).updateCounter(
                                    counterModel.copyWith(tags: updatedTags),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onRemove,
                  ),
                ],
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
}
