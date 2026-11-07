import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/utils/responsive_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../application/portability_cubit.dart';
import '../widgets/conflict_resolution_dialog.dart';

class const BackupRestoreScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Backup and restore'),
        centerTitle: true,
      ),
      body: BlocBuilder<PortabilityCubit, PortabilityState>(
        builder: (context, state) => ResponsiveContent(
          maxWidth: 760,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              AppCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.settings_backup_restore,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Export a portable copy of your account and workout data, or restore it from a JSON backup.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppButton.primary(
                label: 'Export backup',
                icon: Icons.download,
                onPressed: state.isBusy
                    ? null
                    : context.read<PortabilityCubit>().exportBackup,
                isLoading: state.isBusy,
              ),
              const SizedBox(height: 12),
              AppButton.outlined(
                label: 'Import backup',
                icon: Icons.upload,
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
                isLoading: state.isBusy,
              ),
              if (state.isBusy) ...[
                const SizedBox(height: 24),
                const LinearProgressIndicator(),
              ],
              if (state.message != null) ...[
                const SizedBox(height: 20),
                AppCard(
                  child: Text(
                    state.message!,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ],
              if (state.error != null) ...[
                const SizedBox(height: 20),
                AppCard(
                  child: Text(
                    state.error!,
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              ],
              if (state.report case final report?) ...[
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Import Summary',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Imported ${report.imported}, skipped ${report.skipped}, overwritten ${report.overwritten}, duplicated ${report.duplicated}. Analytics sessions rebuilt: ${report.analyticsSessionsRebuilt}.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
