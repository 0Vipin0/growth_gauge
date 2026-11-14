# Technical Implementation Plan: Phase 15 - Progress Sounds & Notifications (Android & Windows)

## 1. Scope & Architecture Summary

* **Platforms**: Android and Windows (iOS/Linux/macOS configurations will be updated on later phases).
* **State Persistence**: User preferences stored via **Drift Database** (integrating with existing Settings state management).
* **Audio Strategy**: Open-source, lightweight bundled assets with global silent fallbacks and full visual/haptic accessibility pairing.
* **Reminders**: Initial setup defaults to **1 notification per day**, fully customizable via UI settings.

---
## 2. Step-by-Step Implementation Roadmap
### Step 15.1: Finalize Notification Service Class (`NotificationService`)
* **Objective**: Adapt the base service skeleton to support active Android and Windows channels using `flutter_local_notifications: ^23.0.2`.

* **Implementation Details**:
* Uncomment and configure `AndroidInitializationSettings` and `WindowsInitializationSettings` inside `_initializeNotifications()` using the correct asset paths (`assets/images/icon.png`) and application IDs from `AndroidManifest.xml`.
* Implement platform-specific payload mappings (`AndroidNotificationDetails` with high importance/priority and `WindowsNotificationDetails` with asset/fallback audio).
* *Verification*: Application initializes notification plugins successfully on both Android and Windows startup without throwing platform channel exceptions.

### Step 15.2: Database Integration for Preferences (Drift)
* **Objective**: Persist user notification and sound configurations reliably using Drift Database.
* **Implementation Details**:
* Define a `NotificationSettingsTable` in Drift containing columns for:
* `notifications_enabled` (bool, default `true`)
* `sound_enabled` (bool, default `true`)
* `vibration_enabled` (bool, default `true`)
* `daily_reminder_enabled` (bool, default `true`)
* `daily_reminder_time` (string/time format, defaulting to user preference)
* `quiet_hours_start` / `quiet_hours_end` (nullable strings)
* Connect the Drift data layer into the existing `SettingsCubit` so preference changes instantly reschedule or cancel active alarms.
* *Verification*: Updating a preference in the UI correctly triggers a write to the Drift database and updates the active alarm scheduler.

### Step 15.3: In-Workout Open-Source Audio & Haptic Cues
* **Objective**: Provide lightweight, open-source audio cues for rest completion and set milestones with mandatory visual/haptic fallbacks.
* **Implementation Details**:
* Source brief, open-source audio snippets (e.g., standard UI beep waveforms) and bundle them under `assets/audio/`.
* Integrate audio playback using a lightweight player package, honoring the `soundEnabled` and `vibrationEnabled` flags from Drift.
* Ensure every audio cue is mirrored by a prominent visual flash/semantic banner and haptic vibration for accessibility.
* *Verification*: Completing a rest interval in `SessionUseCases` triggers the sound/vibration unless muted, while visual indicators always update.

### Step 15.4: Daily Scheduling & Permission Handling (Android & Windows)
* **Objective**: Implement the default 1-notification-per-day schedule with robust Android runtime permission handling.
* **Implementation Details**:
* Utilize `AndroidManifest.xml` permissions (`POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED`) correctly with runtime checks via `isAndroidPermissionGranted()` and `requestPlatformPermissions()`.
* Implement `scheduleDailyNotification` to register a stable daily reminder ID using `zonedSchedule` with `AndroidScheduleMode.exactAllowWhileIdle`.
* Handle device reboots by registering for boot completion broadcasts so daily reminders reschedule automatically.
* *Verification*: Setting a daily reminder successfully schedules an alarm that fires at the requested local time on both Android devices and Windows desktops.

### Step 15.5: Analytics-Driven Summaries & Deduplication
* **Objective**: Populate notifications with meaningful progress data pulled directly from persisted analytics and session states.
* **Implementation Details**:
* Query analytics states (such as weekly volume or personal records) when constructing notification bodies, ensuring lock-screen messages remain concise and privacy-safe.
* Implement deduplication rules to prevent stacking duplicate notifications or spamming alerts for every logged set.
* *Verification*: Scheduled notifications accurately summarize recent workout milestones without generating redundant alerts.


### Step 15.6: Testing and Validation Suite
* **Objective**: Ensure deterministic behavior across notification scheduling, preference toggles, and state persistence.
* **Implementation Details**:
* Write unit tests verifying that `SessionUseCases` events cleanly tie into notification triggers.
* Test Drift database fallback states and permission denial scenarios on Android/Windows emulators.
* *Verification*: All unit and widget tests pass cleanly with zero uncaught platform exceptions.