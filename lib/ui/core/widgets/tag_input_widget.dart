import 'package:flutter/material.dart';

class TagInputWidget extends StatefulWidget {
  final List<String> initialTags;
  final ValueChanged<List<String>> onTagsChanged;

  const TagInputWidget({
    super.key,
    required this.initialTags,
    required this.onTagsChanged,
  });

  @override
  State<TagInputWidget> createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {
  late List<String> _tags;
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  @override
  void didUpdateWidget(covariant TagInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTags != widget.initialTags) {
      _tags = List.from(widget.initialTags);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                widget.onTagsChanged(_tags);
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
                  widget.onTagsChanged(_tags);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }
}
