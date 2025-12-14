import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:growth_gauge/ui/core/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../core/widgets/responsive_form_layout.dart';
import '../../core/widgets/tag_input_widget.dart';
import '../../core/widgets/time_control_widget.dart';
import '../provider/timer_list_provider.dart';

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

  int _targetHours = 0;
  int _targetMinutes = 0;
  int _targetSeconds = 0;
  Duration? _target;
  List<String> _tags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Timer'),
        centerTitle: true,
      ),
      body: ResponsiveFormLayout(
        child: Padding(
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
                const Text('Set Timer Duration',
                    style: TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimeControlWidget(
                      label: 'Hours',
                      value: _hours,
                      onChanged: (value) => setState(() => _hours = value),
                    ),
                    TimeControlWidget(
                      label: 'Minutes',
                      value: _minutes,
                      onChanged: (value) => setState(() => _minutes = value),
                    ),
                    TimeControlWidget(
                      label: 'Seconds',
                      value: _seconds,
                      onChanged: (value) => setState(() => _seconds = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Set Target Duration (Optional)',
                    style: TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TimeControlWidget(
                      label: 'Hours',
                      value: _targetHours,
                      onChanged: (value) =>
                          setState(() => _targetHours = value),
                    ),
                    TimeControlWidget(
                      label: 'Minutes',
                      value: _targetMinutes,
                      onChanged: (value) =>
                          setState(() => _targetMinutes = value),
                    ),
                    TimeControlWidget(
                      label: 'Seconds',
                      value: _targetSeconds,
                      onChanged: (value) =>
                          setState(() => _targetSeconds = value),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TagInputWidget(
                  initialTags: _tags,
                  onTagsChanged: (tags) {
                    setState(() {
                      _tags = tags;
                    });
                  },
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
      ),
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
        tags: _tags,
      );

      context.read<TimerListProvider>().addTimer(newTimer);

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
