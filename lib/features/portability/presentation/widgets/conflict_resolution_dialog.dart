import 'package:flutter/material.dart';

import '../../domain/conflict_strategy.dart';

Future<ConflictStrategy?> showConflictResolutionDialog(BuildContext context) =>
    showDialog<ConflictStrategy>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve imported records'),
        content: const Text(
          'Choose what to do when an imported record has the same ID as a local record.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, ConflictStrategy.keepExisting),
            child: const Text('Keep existing'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ConflictStrategy.overwrite),
            child: const Text('Overwrite'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, ConflictStrategy.duplicateWithNewId),
            child: const Text('Import as copy'),
          ),
        ],
      ),
    );
