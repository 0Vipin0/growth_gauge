import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/portability_cubit.dart';
import '../widgets/conflict_resolution_dialog.dart';

class const BackupRestoreScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Backup and restore')),
    body: BlocBuilder<PortabilityCubit, PortabilityState>(
      builder: (context, state) => ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Export a portable copy of your account and workout data, or restore it from a JSON backup.',
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: state.isBusy
                ? null
                : context.read<PortabilityCubit>().exportBackup,
            icon: const Icon(Icons.download),
            label: const Text('Export backup'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: state.isBusy
                ? null
                : () async {
                    final strategy = await showConflictResolutionDialog(
                      context,
                    );
                    if (context.mounted && strategy != null) {
                      await context.read<PortabilityCubit>().importBackup(
                        strategy,
                      );
                    }
                  },
            icon: const Icon(Icons.upload),
            label: const Text('Import backup'),
          ),
          if (state.isBusy) ...[
            const SizedBox(height: 20),
            const LinearProgressIndicator(),
          ],
          if (state.message != null) ...[
            const SizedBox(height: 20),
            Text(state.message!),
          ],
          if (state.error != null) ...[
            const SizedBox(height: 20),
            Text(
              state.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          if (state.report case final report?) ...[
            const SizedBox(height: 12),
            Text(
              'Imported ${report.imported}, skipped ${report.skipped}, overwritten ${report.overwritten}, duplicated ${report.duplicated}. Analytics sessions rebuilt: ${report.analyticsSessionsRebuilt}.',
            ),
          ],
        ],
      ),
    ),
  );
}
