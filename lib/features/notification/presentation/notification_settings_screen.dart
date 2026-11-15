import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/presentation/utils/responsive_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../application/application.dart';

class const NotificationSettingsScreen({super.key}) extends StatefulWidget {
  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState()
    extends State<NotificationSettingsScreen> {
  late final TextEditingController _delayController;

  @override
  void initState() {
    super.initState();
    // Default to 5 seconds delay test input
    _delayController = TextEditingController(text: '5');
  }

  @override
  void dispose() {
    _delayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listenWhen: (previous, current) =>
          current.message != null && current.message != previous.message,
      listener: (context, state) {
        if (state.message != null && state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final notificationSettings = state.settings;
          final notificationCubit = context.read<NotificationCubit>();
          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              title: const Text('Sounds & Notifications'),
              centerTitle: true,
            ),
            body: ResponsiveContent(
              maxWidth: 800,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  if (state.error != null) ...[
                    AppCard(
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_outlined,
                            color: colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              state.error!,
                              style: TextStyle(color: colorScheme.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 1. MASTER CONTROLS & PERMISSIONS SECTION
                  _buildSectionHeader(context, 'General Controls'),
                  const SizedBox(height: 8),
                  AppCard(
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Enable Notifications'),
                          subtitle: const Text(
                            'Allow local workout reminders and progress updates',
                          ),
                          value: notificationSettings.notificationsEnabled,
                          onChanged: (value) {
                            notificationCubit.updateNotificationSettings(
                              notificationSettings.copyWith(
                                notificationsEnabled: value,
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        SwitchListTile(
                          title: const Text('In-Workout Audio Cues'),
                          subtitle: const Text(
                            'Play low-noise audio cues for rest completion and milestones',
                          ),
                          value: notificationSettings.soundEnabled,
                          onChanged: (value) {
                            notificationCubit.updateNotificationSettings(
                              notificationSettings.copyWith(
                                soundEnabled: value,
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        SwitchListTile(
                          title: const Text('Haptic Vibration'),
                          subtitle: const Text(
                            'Pair audio and status events with tactile device feedback',
                          ),
                          value: notificationSettings.vibrationEnabled,
                          onChanged: (value) {
                            notificationCubit.updateNotificationSettings(
                              notificationSettings.copyWith(
                                vibrationEnabled: value,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 2. PREVIEW & TESTING SECTION
                  _buildSectionHeader(context, 'Test Cues & Previews'),
                  const SizedBox(height: 8),
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preview Audio & Alerts',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Test your sound pack settings, instant local notifications, and background scheduled reminders.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 16),

                          // Row 1: Sound & Instant Notification
                          Row(
                            children: [
                              Expanded(
                                child: AppButton.secondary(
                                  label: 'Test Sound Cue',
                                  onPressed: () {
                                    notificationCubit.testAudioCue();
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppButton.primary(
                                  label: 'Test Notification',
                                  onPressed: () {
                                    notificationCubit.testLocalNotification();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Row 2: Delay Input & Background Delayed Notification Button
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _delayController,
                                  keyboardType: TextInputType.number,
                                  label: 'Notification Delay (in Seconds)',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppButton.secondary(
                                  label: 'Test Delayed (Background)',
                                  onPressed: () {
                                    final seconds =
                                        int.tryParse(_delayController.text) ??
                                        5;
                                    // Assumes your cubit accepts a delay duration parameter
                                    notificationCubit.testDelayedNotification(
                                      Duration(seconds: seconds),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Add Cancel Pending Button
                          SizedBox(
                            width: double.infinity,
                            child: AppButton.ghost(
                              label: 'Cancel Pending Test Notification',
                              onPressed: () {
                                notificationCubit
                                    .cancelPendingTestNotification();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 3. DAILY TRAINING REMINDER SECTION
                  _buildSectionHeader(context, 'Daily Training Reminder'),
                  const SizedBox(height: 8),
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: const Text('Active Daily Reminder'),
                            subtitle: const Text(
                              'Receive 1 scheduled reminder per day to stay consistent',
                            ),
                            value: notificationSettings.dailyReminderEnabled,
                            onChanged: (value) {
                              notificationCubit.updateNotificationSettings(
                                notificationSettings.copyWith(
                                  dailyReminderEnabled: value,
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          ListTile(
                            title: const Text('Reminder Schedule Time'),
                            subtitle: const Text(
                              'Choose when your daily push reminder arrives',
                            ),
                            trailing: AppButton.ghost(
                              label:
                                  notificationSettings.notificationTime?.format(
                                    context,
                                  ) ??
                                  '09:00 AM',
                              onPressed: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      notificationSettings.notificationTime ??
                                      const TimeOfDay(hour: 9, minute: 0),
                                );
                                if (time != null) {
                                  notificationCubit.updateNotificationTime(
                                    time,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
