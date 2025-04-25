import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'model/model.dart';
import 'provider/provider.dart';

class AddTimerPage extends StatefulWidget {
  const AddTimerPage({super.key});

  @override
  State<AddTimerPage> createState() => _AddTimerPageState();
}

class _AddTimerPageState extends State<AddTimerPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Timer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Timer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a timer name';
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
              const Text('Set Timer Duration', style: TextStyle(fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTimeControl('Hours', _hours, (value) {
                    setState(() {
                      _hours = value;
                    });
                  }),
                  _buildTimeControl('Minutes', _minutes, (value) {
                    setState(() {
                      _minutes = value;
                    });
                  }),
                  _buildTimeControl('Seconds', _seconds, (value) {
                    setState(() {
                      _seconds = value;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveTimer,
                child: const Text('Save Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeControl(
    String label,
    int value,
    ValueChanged<int> onChanged,
  ) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                onChanged(value > 0 ? value - 1 : 0);
              },
            ),
            SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onChanged(value + 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _saveTimer() {
    if (_formKey.currentState!.validate()) {
      final Duration duration = Duration(
        hours: _hours,
        minutes: _minutes,
        seconds: _seconds,
      );

      final newTimer = TimerModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text,
        interval: duration,
        logs: [],
      );

      context.read<TimerListProvider>().addTimer(newTimer);

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
