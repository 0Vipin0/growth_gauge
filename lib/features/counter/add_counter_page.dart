import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../utils/navigation_helper.dart';
import 'model/model.dart';
import 'provider/provider.dart';

class AddCounterPage extends StatefulWidget {
  const AddCounterPage({super.key});

  @override
  State<AddCounterPage> createState() => _AddCounterPageState();
}

class _AddCounterPageState extends State<AddCounterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  int _count = 0;
  int? _target;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Counter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Counter Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a counter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Initial Count', style: TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_count > 0) _count--;
                      });
                    },
                  ),
                  Text(
                    '$_count',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _count++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Target (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _target = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveCounter,
                child: const Text('Save Counter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCounter() {
    if (_formKey.currentState!.validate()) {
      final newCounter = CounterModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text,
        count: _count,
        logs: [],
        target: _target, // Include target
      );

      context.read<CounterListProvider>().addCounter(newCounter);

      NavigationHelper.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
