import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/presentation/utils/responsive_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../application/application.dart';
import '../domain/domain.dart';

class const NotificationHistoryScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: const Text('Notification History & Logs'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () =>
                    context.read<NotificationCubit>().loadNotificationLogs(),
                tooltip: 'Refresh Logs',
              ),
            ],
          ),
          body: ResponsiveContent(
            maxWidth: 800,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Control Bar using AppDropdown & AppCard
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Filter by Status',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 180,
                            child: AppDropdown<NotificationStatus?>(
                              value: state.statusFilter,
                              items: [
                                const AppDropdownItem(
                                  value: null,
                                  label: 'All Statuses',
                                ),
                                ...NotificationStatus.values.map(
                                  (status) => AppDropdownItem(
                                    value: status,
                                    label: status.displayName,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                context
                                    .read<NotificationCubit>()
                                    .filterLogsByStatus(value);
                              },
                              label: 'Status',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Header title for list section
                  Text(
                    'Recorded Lifecycle Logs (${state.logs.length})',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Content List or Empty State
                  Expanded(
                    child: state.logs.isEmpty
                        ? Center(
                            child: Text(
                              'No notification logs found.',
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.logs.length,
                            itemBuilder: (context, index) {
                              final log = state.logs[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: AppCard(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                log.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            _buildStatusBadge(
                                              context,
                                              log.status,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          log.body,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const Divider(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Type: ${log.type.displayName}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                            Text(
                                              log.scheduledTime != null
                                                  ? 'Scheduled: ${log.scheduledTime.toString().substring(0, 16)}'
                                                  : 'Created: ${log.createdAt.toString().substring(0, 16)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Manual Status Update Actions
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Update Status:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                            const SizedBox(width: 8),
                                            if (log.status !=
                                                NotificationStatus.delivered)
                                              TextButton.icon(
                                                onPressed: () {
                                                  context
                                                      .read<NotificationCubit>()
                                                      .updateLogStatus(
                                                        log.id,
                                                        NotificationStatus
                                                            .delivered,
                                                      );
                                                },
                                                icon: const Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.green,
                                                ),
                                                label: const Text(
                                                  'Deliver',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            if (log.status !=
                                                NotificationStatus.cancelled)
                                              TextButton.icon(
                                                onPressed: () {
                                                  context
                                                      .read<NotificationCubit>()
                                                      .updateLogStatus(
                                                        log.id,
                                                        NotificationStatus
                                                            .cancelled,
                                                      );
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  size: 16,
                                                  color: Colors.orange,
                                                ),
                                                label: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(BuildContext context, NotificationStatus status) {
    final color = status.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.displayName.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
