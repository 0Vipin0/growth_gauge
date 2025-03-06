import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'counter_details_page.dart';
import 'counter_list_provider.dart';
import 'counter_model.dart';
import 'reusable_counter_provider.dart';

class ReusableCounter extends StatelessWidget {
  final CounterModel counterModel;
  final VoidCallback onRemove;

  const ReusableCounter({
    super.key,
    required this.counterModel,
    required this.onRemove,
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
              subtitle: Text('Count: ${counterProvider.count}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      counterProvider.decreaseCounter();
                      Provider.of<CounterListProvider>(context, listen: false)
                          .updateCounter(counterProvider.counter);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      counterProvider.increaseCounter();
                      Provider.of<CounterListProvider>(context, listen: false)
                          .updateCounter(counterProvider.counter);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onRemove,
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CounterDetailsPage(counter: counterModel),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
