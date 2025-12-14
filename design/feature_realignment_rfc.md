# RFC: App Features Realignment and UI Redesign (Issue #134)

## Summary

This RFC summarizes the goals from issue #134 and proposes an incremental implementation plan to make the app more extensible and improve large-form-factor UI.

## Goals

- Introduce `UserProfile`, `Activity`, `Goal`, and `WorkoutTemplate` domain models.
- Add providers and services following the existing `ChangeNotifier` pattern.
- Move persistence from `SharedPreferences` to a local DB (Drift) with migration support.
- Enhance insights: streak heatmaps, X-day charts, and export/import utilities.
- Add local auth (biometric + PIN), TTS service, and scheduled notifications.

## Incremental Plan

1. Scaffold feature folders: `features/profile`, `features/activity`, `features/insights`.
2. Implement core models (`UserProfile` added in this change), and providers (e.g., `UserProfileProvider`).
3. Add persistence adapters and repositories; add DB migrations using Drift.
4. Create UI placeholders and wire routing; add accessible theme/font settings.
5. Implement advanced features (TTS, LAN sync, import/export, fitness assessment).
6. Add tests, integration tests, and docs.

## Current Change

- Added `UserProfile` model (JSON serializable) and `UserProfileProvider`.
- Added basic tests for model serialization and provider initialization.
- Registered `UserProfileProvider` in `DependencyProvider`.
- Added Drift-based persistence layer (`AppDatabase`) and Drift-backed repositories for `UserProfile` and `Activity`.
- Added repository and DB tests using an in-memory database.

## Next Steps / Open Questions

- Choose DB (Drift recommended) and design schema for migrations.
- Define TTS and Notification service APIs.
- Plan UI screens and interaction flows for Profile and Workout Builder.

---
Update this RFC as the design matures and tasks are completed.
