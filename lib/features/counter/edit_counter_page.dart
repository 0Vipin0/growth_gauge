import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/navigation_helper.dart';
import '../common/presentation/widgets/responsive_form_layout.dart';
import '../common/presentation/widgets/tag_input_widget.dart';
import 'model/model.dart';
import 'provider/provider.dart';

class EditCounterPage extends StatefulWidget {
  final CounterModel counter;
  const EditCounterPage({super.key, required this.counter});

  @override
  State<EditCounterPage> createState() => _EditCounterPageState();
}

class _EditCounterPageState extends State<EditCounterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  late int _count;
  int? _target;
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.counter.name);
    _descriptionController =
        TextEditingController(text: widget.counter.description);
    _count = widget.counter.count;
    _target = widget.counter.target;
    _tags = List.from(widget.counter.tags ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Counter'),
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
                    const Text('Count', style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      tooltip: 'Decrease',
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
                      tooltip: 'Increase',
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
                  initialValue: _target?.toString(),
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
                  onPressed: _updateCounter,
                  child: const Text('Update Counter'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateCounter() {
    if (_formKey.currentState!.validate()) {
      final updatedCounter = widget.counter.copyWith(
        name: _nameController.text,
        description: _descriptionController.text,
        count: _count,
        target: _target,
        tags: _tags,
      );

      context.read<CounterListProvider>().updateCounter(updatedCounter);

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
