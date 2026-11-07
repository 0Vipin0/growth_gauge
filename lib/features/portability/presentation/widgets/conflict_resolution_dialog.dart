import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../domain/conflict_strategy.dart';

Future<ConflictStrategy?> showConflictResolutionDialog(BuildContext context) =>
    showDialog<ConflictStrategy>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve imported records'),
        content: const Text(
          'Choose what to do when an imported record has the same ID as a local record.',
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              AppButton.ghost(
                label: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              AppButton.outlined(
                label: 'Keep existing',
                onPressed: () =>
                    Navigator.pop(context, ConflictStrategy.keepExisting),
              ),
              AppButton.destructive(
                label: 'Overwrite',
                onPressed: () =>
                    Navigator.pop(context, ConflictStrategy.overwrite),
              ),
              AppButton.primary(
                label: 'Import as copy',
                onPressed: () =>
                    Navigator.pop(context, ConflictStrategy.duplicateWithNewId),
              ),
            ],
          ),
        ],
      ),
    );
