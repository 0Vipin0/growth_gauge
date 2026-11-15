import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/presentation/utils/responsive_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../application/application.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        final notificationCubit = context.read<NotificationCubit>();

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: const Text('Notification History & Logs'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => notificationCubit.loadNotificationLogs(),
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
                            child: AppDropdown<String>(
                              value: state.statusFilter ?? 'all',
                              items: const [
                                AppDropdownItem(
                                  value: 'all',
                                  label: 'All Statuses',
                                ),
                                AppDropdownItem(
                                  value: 'scheduled',
                                  label: 'Scheduled',
                                ),
                                AppDropdownItem(
                                  value: 'delivered',
                                  label: 'Delivered',
                                ),
                                AppDropdownItem(
                                  value: 'cancelled',
                                  label: 'Cancelled',
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  notificationCubit.filterLogsByStatus(value);
                                }
                              },
                              label: '',
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
                                              'Type: ${log.type} | ID: ${log.notificationId}',
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

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    switch (status) {
      case 'scheduled':
        color = Colors.blue;
        break;
      case 'delivered':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
