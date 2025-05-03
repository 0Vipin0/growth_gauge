import 'package:flutter/material.dart';
import 'package:growth_gauge/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../utils/navigation_helper.dart';
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
  final TextEditingController _tagController =
      TextEditingController(); // Controller for tags

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  int _targetHours = 0;
  int _targetMinutes = 0;
  int _targetSeconds = 0;
  Duration? _target;
  final List<String> _tags = []; // List to store tags

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Timer'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > kTabletScreenSize) {
            return Center(
              child: SizedBox(
                width: 600,
                child: _buildForm(),
              ),
            );
          } else {
            return _buildForm();
          }
        },
      ),
    );
  }

  Padding _buildForm() {
    return Padding(
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
            const SizedBox(height: 16),
            const Text('Set Target Duration (Optional)',
                style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeControl('Hours', _targetHours, (value) {
                  setState(() {
                    _targetHours = value;
                  });
                }),
                _buildTimeControl('Minutes', _targetMinutes, (value) {
                  setState(() {
                    _targetMinutes = value;
                  });
                }),
                _buildTimeControl('Seconds', _targetSeconds, (value) {
                  setState(() {
                    _targetSeconds = value;
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tagController,
              decoration: const InputDecoration(
                labelText: 'Add Tag',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  if (value.isNotEmpty && !_tags.contains(value)) {
                    _tags.add(value);
                    _tagController.clear();
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  onDeleted: () {
                    setState(() {
                      _tags.remove(tag);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveTimer,
              child: const Text('Save Timer'),
            ),
          ],
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
              tooltip: 'Decrease',
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
              tooltip: 'Increase',
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
      _target = Duration(
        hours: _targetHours,
        minutes: _targetMinutes,
        seconds: _targetSeconds,
      );

      final newTimer = TimerModel(
        id: const Uuid().v4(),
        name: _nameController.text,
        description: _descriptionController.text,
        interval: duration,
        logs: [],
        target: _target,
        tags: _tags, // Save tags
      );

      context.read<TimerListProvider>().addTimer(newTimer);

      NavigationHelper.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
