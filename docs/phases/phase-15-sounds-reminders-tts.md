## 18. Phase 15: Progress Sounds and Notifications

Finish the existing notification service and add opt-in, low-noise sound and local notification experiences that help users understand workout progress and stay motivated. Use session and analytics state as the source of truth. Keep essential status visible in the app, allow quiet operation, and avoid making permissions, sound, or notification delivery necessary for workout completion.

### 15.1 Product and Platform Rules

- Separate immediate in-workout audio cues from scheduled/background local notifications. Cues may report rest completion, set/session milestones, or user-configured progress; notifications may summarize meaningful progress or a chosen training reminder.
- Make available reminder settings configurable. The legacy source specifies customizable scheduled local notifications that may reference current goals or progress. Make sound, vibration, notification categories, quiet hours, reminder schedule, and motivational messaging configurable. Respect OS notification permissions and avoid repeated prompts after denial.
- Keep messages truthful, concise, privacy-aware on lock screens, and based on persisted session/analytics state. Avoid shame, pressure, excessive frequency, duplicate milestones, or notifications for every logged set by default.
- Request notification permission contextually, explain its value first, and keep the core app usable when permission is denied. Provide a preview/test action and a clear disable-all control.
- Use stable notification identifiers and cancel/reschedule when preferences change, reminders are disabled, or a workout is completed. Handle timezone and daylight-saving changes for scheduled reminders.
- Keep audio assets small, licensed, bundled/offline where possible, and provide a silent option. Accessibility must not depend on hearing the sound; pair cues with visual/semantic feedback and haptics where supported.

### 15.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 15.1** | Audit notification service and progress events | `[ ] PLANNED` | Map session lifecycle, rest completion, goal progress, analytics milestones, current settings, permissions, and platform plugin support. |
| **Step 15.2** | Define motivation and notification preferences | `[ ] PLANNED` | Define opt-in categories, cadence/quiet hours, privacy-safe lock-screen text, sound controls, and suppression rules. |
| **Step 15.3** | Implement in-workout sound and status cues | `[ ] PLANNED` | Add configurable milestone/rest cues with silent fallback, lifecycle-safe audio handling, and visual/semantic equivalents. |
| **Step 15.4** | Complete local notifications and scheduling | `[ ] PLANNED` | Initialize platform plugins, request permissions contextually, schedule/cancel reminders, and handle timezone and preference updates. |
| **Step 15.5** | Add progress summaries and deduplication | `[ ] PLANNED` | Create accurate opt-in summaries from persisted progress; prevent duplicate, stale, or excessive notifications. |
| **Step 15.6** | Add service, preference, and platform tests | `[ ] PLANNED` | Test scheduling, permission denial, time changes, sound-off behavior, cancellation, deduplication, privacy text, and event-to-message mapping. |

### 15.3 Acceptance Criteria

- Users can configure sound and notification behavior independently, preview cues, choose quiet periods, and disable all optional alerts.
- Rest/session feedback remains understandable without sound or notification permission; notification denial does not impair workout flows.
- Notifications reflect persisted progress, respect frequency/privacy preferences, and are cancelled or updated when stale.
- Service logic and settings have deterministic tests, with device checks for sound, permissions, scheduling, and lifecycle behavior on supported platforms.

---
