## 21. Legacy Feature Parity Crosswalk (Retrofit Checklist)

This crosswalk maps `features.md` into the existing phase structure. It does not reinstate the retired generic counter/timer implementation. Statuses below are requirements to verify against the implementation; they are not claims that work is complete.

| Legacy / realigned requirement | Target phase(s) in this plan | Required coverage |
|---|---|---|
| Organized counters and timers / goal-centric activity list | Phases 3, 4, 5, 12 | Count- and time-based activities; goal grouping/sorting; progress bars; activity detail views. |
| Heatmaps and 7-day charts | Phase 4 | Streak/calendar heatmaps plus 7/14/30/90-day charts and explicit date-window behavior. |
| JSON and CSV export; restore/import | Phase 6 | Versioned lossless JSON export/import with checksum, migrations, conflicts, and rebuild; separate analysis-oriented CSV export. |
| Persistent local storage | Phases 1, 6 | Keep the plan's existing Drift/SQLite storage architecture and schema-migration work; do not restore Shared Preferences as the fitness-record store. |
| Themes and fonts | Phases 12, 17 | User-selectable themes and fonts; exact theme variants, font choices, and size presets: **NA not specified in the legacy source**. |
| Biometric lock with PIN fallback | Phase 14 | Native biometric capability checks, explicit PIN fallback, secure salted PIN verifier, throttling/recovery, protected-route gating. |
| Scheduled local notifications | Phase 15 | Customizable scheduled local reminders; exact cadence choices and message templates: **NA not specified in the legacy source**. |
| Fitness profile and constraints | Phase 5 | Baseline height/weight/resting HR and supported metrics; injuries/constraints and equipment limitations. |
| Fitness assessment score | Phase 5 (with Phase 4 analytics inputs) | Composite score based on user data/activity history; formula, weights, scale, and thresholds: **NA not specified in the legacy source**. |
| Daily log (mood, notes, RPE) | Phases 3, 4 | Persisted daily/session fields and display in history; nullable analytics handling. |
| Preset/custom workout and interval timer | Phases 2, 3 | Saved routines/templates plus work/rest/cooldown interval blocks, pause/resume/recovery. |
| Voice-guided coach (TTS) | Phases 3, 15 | Optional TTS interval cues, user controls, lifecycle safety, visual/semantic equivalents and silent mode. |
| GitHub Actions build/release artifacts | Phase 16 | Consistent SDK/check commands, secure CI, tag-based release builds and verified downloadable artifacts. |

### Cross-cutting acceptance gate

Before declaring legacy parity complete, verify each row against code and tests, update the relevant phase tracker/status only after evidence exists, and record any deliberately deferred item. Do not change the current architecture or reintroduce `lib/features/counter/`, `lib/features/timer/`, legacy Shared Preferences repositories, or obsolete routes merely to achieve feature-name parity. Where a legacy featureâ€™s detailed behavior is not specified, mark it **NA** rather than inventing requirements.


---

## 22. Legacy Design Image Retrofit Plan

This section maps each legacy UI design image (from `docs/Legacy/design/`) to the current implementation, identifies what is already built, and documents the specific gaps that must be addressed. All work is integrated into the existing phases above; the phase references below are the authoritative home for each piece of work.

> **Design language reference (from legacy images)**
> - **Primary background**: near-black green-tinted surface (`#0D1F0D` / `#0E1A0E`)
> - **Brand accent**: bright green (`#00E676`)
> - **Card style**: rounded corners (~16 dp), `surfaceContainer` dark fill, no harsh borders
> - **Default font family**: `Manrope` geometric sans-serif
> - **CTA style**: filled rounded button in accent green with dark label
> - **Icon containers**: circular filled icons per activity type (runner = Warm Up, timer = Interval, dumbbell = Reps, clock = Rest, snowflake = Cool Down)

---

### 22.1 Home / Training Hub

**Source image:** `HomePage-1.png`  
**Current file:** [`lib/features/home/fitness_hub_page.dart`](../lib/features/home/fitness_hub_page.dart)  
**Target phase:** Phase 7 polish + Phase 12 responsive (already in progress)

| Component | Status | Notes |
|---|---|---|
| Greeting header with user name and avatar circle | Implemented | Present in `home_page.dart` header |
| Time-range selector (Today / Week / Month) | Implemented | Exists in `FitnessHubPage` |
| Quick Start horizontal carousel | Implemented | `quick_start_section.dart` |
| Explore Library CTA banner | Implemented | In `fitness_hub_page.dart` |
| Weekly stats summary cards (active time, workouts count) | Implemented | Grid cards present |
| **"This Week" calories burned donut ring progress indicator** | Missing | Large ring with calories in center and weekly goal label; maps to Phase 7 Step 7.4 polish |
| **7-day Map activity tile row with checkmarks** | Missing | Each day shows a small circle tile: filled accent green with checkmark = completed, muted = missed; Phase 12 / Phase 17 |
| **Streak badge overlaid on activity tiles** | Missing | "12-Day Streak pill badge; Phase 7 / Phase 15 |
| **"Details" link in "This Week" header , Analytics Trends route** | Missing | Tappable text that navigates to the Trends screen; Phase 10 routing already complete, needs UI link wired |

---

### 22.2 Workout Builder (Template Editor)

**Source images:** `New-Workout-1.png`, `Edit-Workout-1.png`  
**Current files:** [`lib/features/template/presentation/template_editor_screen.dart`](../lib/features/template/presentation/template_editor_screen.dart), [`lib/features/template/presentation/template_detail_screen.dart`](../lib/features/template/presentation/template_detail_screen.dart)  
**Target phase:** Phase 2 (completed) + Phase 13 exercise steps + Phase 15 sound/voice toggles

| Component | Status | Notes |
|---|---|---|
| Editable workout name field at top | Implemented | `template_editor_screen.dart` |
| Block structure list (Warm Up, Blocks, Cool Down) | Implemented | Drag-reorderable block list |
| Per-block interval timer vs. reps distinction | Implemented | Measurement profile per block |
| "+ Add Block" dashed button | Implemented | Present in editor |
| **Live reactive "Total Duration" header** | Missing | Shows computed sum of all block durations in real time as blocks are added/edited; Phase 7 polish |
| **Base template selector cards (Custom / HIIT / Strength)** | Missing | Visual card picker at top of new-template flow with icon + label + selected state ring; Phase 2 enhancement or Phase 17 widget system |
| **Warm Up and Cool Down blocks shown as locked (non-removable)** | Missing | Swipe-to-delete disabled, lock icon shown; Phase 3 session rules |
| **Sound Effects toggle + Voice Guide toggle per template** | Missing | Two switch tiles at bottom of editor; sound = play audio cues; voice = TTS coach; links to Phase 15 |

---

### 22.3 Active Session Player

**Source images:** `Running-Workout-1.png`, `Running-Workout-2.png`  
**Current file:** [`lib/features/session/presentation/active_session_screen.dart`](../lib/features/session/presentation/active_session_screen.dart)  
**Target phase:** Phase 3 (completed) + Phase 7 polish

| Component | Status | Notes |
|---|---|---|
| Countdown timer display | Implemented | `active_session_screen.dart` |
| Rep counter | Implemented | Present for reps-based exercises |
| Pause / Resume button | Implemented | Transport controls present |
| Block Progress bar | Implemented | Progress indicator present |
| "Next Up" card (next exercise name and type) | Implemented | Footer card present |
| **Exercise icon circle (type-specific circular icon container)** | Missing | Large centered circle with themed icon: runner (Warm Up), timer (Interval), dumbbell (Reps), clock (Rest), snowflake (Cool Down); Phase 7 / Phase 17 |
| **Exercise type badge chip (INTERVAL / REPS label pill)** | Missing | Pill chip below exercise name indicating measurement type; Phase 7 |
| **Large countdown / rep counter with Â±1 circular tap buttons** | Missing | "+1" / "-1" buttons in circular outlines flanking the large digit counter for reps; Phase 7 |
| **Rounds N/8 footer card** | Missing | Persistent bottom card showing "Round 2 of 4" progress; Phase 7 |
| **Previous block transport button** | Missing | Three-button transport row: skip-back / pause / skip-forward; Phase 3/7 |

---

### 22.4 Session Summary (Deep Dive)

**Source image:** `Workout-Completed-1.png`  
**Current file:** [`lib/features/session/presentation/session_summary_screen.dart`](../lib/features/session/presentation/session_summary_screen.dart)  
**Target phase:** Phase 3 (completed) + Phase 7 polish

| Component | Status | Notes |
|---|---|---|
| RPE slider (Easy , Max) | Implemented | `session_summary_screen.dart` |
| "How did you feel?" emoji row (Tired / Neutral / Good / Energetic / Great) | Implemented | Mood selector present |
| Notes text area | Implemented | Free-text notes field |
| "Save Log" CTA button | Implemented | Primary action |
| **Total Duration + Completed Date header card** | Missing | Top section showing "45 min" duration and "Completed Mon, 14 Oct" date badge; Phase 7 |
| **Heart Rate input with zone annotation** | Missing | Average heart rate field with inline "Zone 3 Moderate" annotation derived from HR zones; Phase 18 biometric intelligence |
| **TIMELINE read-only block list at bottom** | Missing | Scrollable list of each executed block with block name, type icon, and duration; Phase 7 |

---

### 22.5 Analytics & Trends Screen

**Source image:** `Summary-1.png`  
**Current file:** [`lib/features/analytics/presentation/screens/analytics_dashboard_screen.dart`](../lib/features/analytics/presentation/screens/analytics_dashboard_screen.dart)  
**Target phase:** Phase 4 (completed) + Phase 13 + Phase 18

| Component | Status | Notes |
|---|---|---|
| Volume bar chart | Implemented | `fl_chart` bar chart present |
| Exercise progression chart (PR trophies) | Implemented | PR trophy shelf implemented |
| Workout frequency chart | Implemented | Frequency visualization present |
| **Monthly consistency calendar heatmap** | Missing | Navigable month calendar where each day cell is colored by activity intensity or marked as completed; Phase 4 enhancement / Phase 13 |
| **Average Heart Rate line chart with tooltip** | Missing | Line chart of avg HR per session with interactive tooltip showing exact value; Phase 18 (requires HR data from summary) |
| **Total Duration trend bar chart with tooltip** | Missing | Stacked or grouped bar chart of workout duration per day/week; Phase 4 enhancement |
| **1W / 1M / 3M / YTD segmented period toggle** | Missing | Four-segment control at top of Performance section to filter all charts; Phase 4 enhancement |
| **% growth vs. previous period badge** | Missing | Green badge " 12% vs last month" shown below each chart; Phase 4 enhancement |
| **"12-Day Streak" badge in Consistency section** | Missing | Streak badge with flame icon displayed in the calendar header; Phase 15 / Phase 7 |

---

### 22.6 Profile Setup 3-Step Onboarding Wizard

**Source images:** `Profile-Setup-1.png`, `Constraints-1.png`  
**Current file:** [`lib/features/user/presentation/`](../lib/features/user/presentation/)  
**Target phase:** Phase 5 (completed) + Phase 18

| Component | Status | Notes |
|---|---|---|
| Height / Weight / RHR biometric input fields | Implemented | `profile_screen.dart` |
| Equipment inventory sheet | Implemented | `equipment_inventory_sheet.dart` |
| **3-step wizard with step indicator (Step N of 3)** | Missing | Linear stepper UI with progress dots or numbered chips; must not use a new state management pattern wire to existing `UserCubit` |
| **Step 1: Biological Sex toggle (Male / Female segmented control)** | Missing | Segmented toggle widget; Phase 5 / Phase 17 widget system |
| **Step 1: Imperial / Metric unit toggle** | Missing | Two-option segmented control switching height/weight field labels and expected range; Phase 5 (unit conversion in `core/units/` already exists) |
| **Step 1: Activity Level horizontal chip row** | Missing | Selectable chips: Sedentary / Light / Moderate / Heavy / Athletic; Phase 5 enhancement |
| **Step 1: Optional body composition fields** | Missing | Neck / Waist / Hip fields shown as collapsible "Optional" section for body-fat estimation; Phase 18 biometric intelligence |
| **Step 2: Goal Selection grid** | Missing | Cards with icon + label for goals (Lose Weight / Build Muscle / Improve Endurance / General Fitness etc.); Phase 5 |
| **Step 3: Constraints screen** | Missing | Body areas to avoid chips, equipment checklist, Daily Time Cap slider (15Mâ€“120M), Dietary Restrictions dropdown + allergen text field, "Finish Setup" CTA; Phase 5 enhancement do not duplicate `equipment_inventory_sheet.dart`, extend it |

---

### 22.7 Settings Hub

**Source image:** `Settings-1.png`  
**Current file:** [`lib/features/settings/settings_page.dart`](../lib/features/settings/settings_page.dart)  
**Target phase:** Phase 14 (auth) + Phase 15 (reminders) + Phase 17 (appearance) + Phase 7 polish

| Component | Status | Notes |
|---|---|---|
| Theme toggle | Implemented | Dark/Light/System toggle in settings |
| Auth section (biometric lock) | Partially | Tile present but biometric flow incomplete (Phase 14) |
| Backup / Restore tiles | Implemented | Portability tiles present |
| **User profile summary card at top** | Missing | Large card with avatar circle, display name, "Pro Member" badge (if applicable), and pencil edit icon that routes to `ProfileScreen`; Phase 7 |
| **"UI Customization" tile , Appearance screen route** | Missing | Navigates to dedicated Appearance screen (Section 22.8); Phase 17 |
| **"Growth Reminders" tile , Reminders list route** | Missing | Navigates to `GrowthRemindersScreen` (Section 22.9); Phase 15 |
| **Help & FAQ external link tile** | Missing | Opens external URL or in-app web view; Phase 7 |
| **About Us tile** | Missing | Shows app version, legal, credits; Phase 7 |
| **Log Out destructive button** | Missing | Bottom of settings list, destructive red label, triggers account sign-out confirmation; Phase 7 |
| **App version string at bottom** | Missing | Small muted text "v1.0.0 (42)" below Log Out; Phase 7 |

---

### 22.8 Appearance Screen

**Source image:** `Settings-2.png`  
**Current files:** [`lib/features/settings/config/theme_config.dart`](../lib/features/settings/config/theme_config.dart)  
**Target phase:** Phase 17 (Adaptive Modular Widget System & Design System)

> This entire screen needs to be built. It does not yet exist as a standalone route.

| Component | Status | Notes |
|---|---|---|
| **Light / Dark / System segmented control** | Missing | Three-option toggle at top of appearance screen (currently buried in settings page as a dropdown/switch) |
| **Color seed grid (7 tiles + Custom)** | Missing | Tappable color swatch tiles with labels: Forest âœ“ (default), Midnight, Amber, Slate, Rust, Moss, Cyan, and a "Custom" tile with palette icon; selected tile shows a checkmark ring; drives `FitnessTheme` seed color |
| **Font Style radio list** | Missing | Radio-list group: "Manrope Default Geometric Sans" (default âœ“), "Open Dyslexic Accessibility Focused", "System Default San Francisco / Roboto"; a "More Fonts" expandable row may follow |
| **Text Size slider (A , A with % badge)** | Missing | Continuous slider between small-A and large-A icons; current scale shown as "100%" badge that updates as slider moves |
| **LIVE PREVIEW card** | Missing | Card below controls showing sample heading + body text rendered in the currently selected font family, scale, and active theme in real time no restart required |
| **Route registration for Appearance screen** | Missing | Add `appRouteAppearance` in `app_routes.dart`; navigate from Settings tile |

---

### 22.9 Growth Reminders Screen

**Source images:** `Growth-Reminders-1.png`, `Edit-Reminders-1.png`  
**Current service:** [`lib/features/user/`](../lib/features/user/) notification service (basic scheduling exists)  
**Target phase:** Phase 15 (Progress Sounds, Growth Reminders & TTS Coach)

> The `NotificationService` exists but the full Reminders UI does not.

| Component | Status | Notes |
|---|---|---|
| Basic local notification scheduling in `NotificationService` | Implemented | Foundation exists |
| **`GrowthRemindersScreen` route** | Missing | New screen; register as `appRouteGrowthReminders` in `app_routes.dart` |
| **"Enable All Reminders" master toggle + motivation copy** | Missing | Top section with single switch that enables/disables all scheduled reminders at once |
| **Reminder list items** | Missing | Each row: icon (emoji), label, time string, recurrence label, edit-pencil icon button, active switch toggle |
| **Quick Add inline form** | Missing | Collapsed/expanded section within the same screen: Label field, Time picker row, Repeat dropdown (Daily / Weekdays / Weekends / Custom), Motivational Message textarea (120-char counter), "Save Reminder" CTA |
| **Template variable insert chips** | Missing | Chips below the message textarea: `[Streak]`, `[Current Goal]`, `[Name]`; tapping inserts the token at the cursor position |
| **NOTIFICATION PREVIEW mock card** | Missing | Read-only card that substitutes live variable values (highlighted in accent green) into the composed message, simulating the lock-screen notification appearance |
| **`EditReminderScreen` route** | Missing | Full edit form navigated from the edit-pencil icon; includes icon picker emoji row, Label + Time + Repeat fields, "Reminder Active" toggle, Motivational Message + variable chips + preview; register as `appRouteEditReminder` |

---

### 22.10 Data Management (Backup & Restore)

**Source image:** `Data-Management-1.png`  
**Current file:** [`lib/features/portability/presentation/screens/backup_restore_screen.dart`](../lib/features/portability/presentation/screens/backup_restore_screen.dart)  
**Target phase:** Phase 6 (completed) + Phase 7 UI polish

| Component | Status | Notes |
|---|---|---|
| JSON Backup export and restore logic | Implemented | `portability_cubit.dart`, `export_data_use_case.dart`, `import_data_use_case.dart` |
| Conflict resolution dialog | Implemented | `conflict_resolution_dialog.dart` |
| Checksum verification & migrations | Implemented | `checksum_validator.dart`, `migration_registry.dart` |
| **Dedicated "JSON Backup" card** | Missing | Card with code icon `{}`, title "JSON Backup", subtitle "Full history & settings Best for migration", and outline "Generate" button with download icon; Phase 7 UI polish |
| **Dedicated "CSV Spreadsheet" export card** | Missing | Card with table/spreadsheet icon, title "CSV Spreadsheet", subtitle "Activity metrics only For Excel or Sheets", and outline "Generate" button; Phase 6 / Phase 7 UI polish |
| **Dashed-border "Select File to Restore" picker zone** | Missing | Prominent card with dashed border, centered green circular upload icon, "Tap to browse files", and amber warning chip. This may overwrite existing logs."; Phase 7 UI polish |
| **Export/Restore "HISTORY" timeline list** | Missing | Vertical stepper/timeline showing history of exports and imports with timestamp (e.g. "Exported CSV Today 10:00 AM", "Exported JSON Oct 24") and status dots; Phase 6 / Phase 7 |

---

### 22.11 Retrofit Priority Summary

The table below ranks unbuilt components by user-facing impact to guide sequencing within each phase.

| Priority | Screen Area | Missing Component | Target Phase |
|---|---|---|---|
| High | Home / Hub | Dynamic "This Week" analytics integration (real calories, active time, workouts, Details link) | Phase 7 (Step 7.5) |
| High | Home / Hub | Calories donut ring + 7-day activity tiles + streak badge | Phase 7 / Phase 17 |
| High | Onboarding | 3-step first-launch wizard (Body Metrics, Goals, Constraints) | Phase 5 (Step 5.5) |
| High | Templates | Delete / Archive workout template with confirmation dialog & filter | Phase 2 (Step 2.8) |
| High | Exercise Steps | Sequential setup & execution steps timeline + custom step builder | Phase 13 (Step 13.7) |
| High | Active Session | Exercise icon circle + type badge + Â±1 rep buttons | Phase 7 |
| High | Session Summary | Total Duration header + TIMELINE block list | Phase 7 |
| High | Settings | User profile card + missing tiles (Reminders, Appearance, Log Out, version) | Phase 7 |
| High | Data Management | Dual export cards (JSON/CSV) + dashed restore zone + history timeline | Phase 7 |
| Medium | Appearance Screen | Entire screen (seed grid, font picker, text size slider, live preview) | Phase 17 |
| Medium | Growth Reminders | Full `GrowthRemindersScreen` + `EditReminderScreen` | Phase 15 |
| Medium | Analytics | Calendar heatmap + period toggle + growth badges | Phase 4 enhancement |
| Medium | Workout Builder | Live Total Duration header + base template selector + locked blocks + sound/voice toggles | Phase 7 / Phase 15 |
| Lower | Session Summary | HR input with zone annotation | Phase 18 |
| Lower | Analytics | Avg HR line chart + Total Duration bar chart | Phase 18 |
| Lower | Profile Setup | Optional body composition fields (Neck/Waist/Hip) | Phase 18 |

---

### 22.12 Design Consistency Checklist (Cross-cutting)

Apply the following to every retrofit component do not implement a component without satisfying these:

- [ ] Background uses `Theme.of(context).colorScheme.surface` / `surfaceContainer`; do not hard-code hex values
- [ ] Accent green is `Theme.of(context).colorScheme.primary` (driven by the seed color in Phase 17)
- [ ] Rounded corners use `Theme.of(context).shape.large` (or explicit `BorderRadius.circular(16)` from the design token)
- [ ] Typography uses `Theme.of(context).textTheme` roles `headlineMedium`, `titleLarge`, `bodyMedium`, `labelSmall`; do not set raw `fontSize` values in feature code
- [ ] All new routes use `context.push(routePath, extra: ...)` via GoRouter never `Navigator.of(context).push(MaterialPageRoute(...))`
- [ ] New screens follow the clean-architecture layer separation: domain , application (Cubit/Bloc) , infrastructure , presentation
- [ ] Run `./scripts/check.ps1` (analysis + format + tests) before marking any component done

---

### 22.13 Comprehensive Current Implementation Audit (`docs/design/` 23-Image Analysis)

This section maps all 23 live screenshots captured in `docs/design/` against the codebase, cataloging what is currently built, responsive presentation differences, visual bugs/artifacts, and exact implementation plan actions.

#### 1. Full Screen-by-Screen Mapping Table

| Screen & Artifacts | Visual State in `docs/design/` Screenshots | Code Implementation Status | Identified Gaps & Required Actions |
|---|---|---|---|
| **Home Dashboard**<br>`HomePage-Mobile.png`<br>`HomePage-Desktop.png` | Responsive shell (Rail on desktop, Bottom bar on mobile)<br>Calories card: `3,240 kcal`, `85%` donut ring<br>Stats cards: `0h 0m` active time, `0` workouts<br>Activity trends: `Week \| Month \| Quarter` toggle, empty day/week slots<br>Quick Start carousel with workout cards | **Partially Implemented & Hardcoded**<br>Shell navigation adapts properly.<br>`CaloriesCard` contains hardcoded literals (`3,240`, `85%`).<br>`workoutHistory` defaults to empty `const []`.<br>"Details" link button has empty callback `onPressed: () {}`. | **Step 7.5:** Wire `FitnessHubPage` to `AnalyticsCubit` / `DailySummary` Drift stream. Compute live active time, workouts, and estimated kcal. Route "Details" to `appRouteAnalytics`. |
| **Exercise Catalog**<br>`ExerciseCatalog-Mobile.png`<br>`ExerciseCatalog-Desktop.png` | Responsive view (single column list on mobile, 3-column card grid on desktop)<br>Search bar + 4 taxonomy filters (`Region`, `Pattern`, `Muscle`, `Equipment`)<br>FAB `+ Custom exercise` | **Implemented**<br>Full taxonomy filtering and search work.<br>Custom exercise modal functions. | Ensure responsive constraints prevent horizontal overflow on extreme desktop widths. |
| **Exercise Detail**<br>`ExerciseDetailPage-Mobile.png`<br>`ExerciseDetails-Desktop.png` | Large title + short description<br>Card with metadata: Movement Pattern, Body Region, Primary Muscles, Equipment Required, Tracking Metric | **Severely Incomplete**<br>The page is almost empty below the metadata card.<br>No setup instructions or execution steps.<br>No exercise illustrations/diagrams.<br>No relationship/progression links. | **Step 13.7:** Display sequential `setupInstructions` and `executionInstructions` as a numbered timeline/stepper. Surface linked progressions/regressions. |
| **Exercise Progression**<br>`ExerciseProgression-Mobile.png` | Exercise dropdown selector (`Dumbbell Hammer Curl`)<br>Line chart: Estimated 1RM Progression (kg) with trend line<br>"Completed Sets History" cards with RPE and 1RM calculation | **Implemented**<br>Dropdown selection, 1RM trend chart, and set history cards render cleanly. | Enhance chart tooltips for individual data points on desktop hover. |
| **Workout Templates**<br>`WorkoutTemplatePage-Mobile.png`<br>`WorkoutTemplatePage-Desktop.png` | Scrollable list of templates with title, description, and chevron `>`<br>FAB `+ New template`<br>Description text contains raw citation artifacts (e.g. `[cite: 4]`, `[cite: 2, 4]`) | **Partially Implemented / Missing Archival**<br>Templates query and display from Drift.<br>**No delete or archive affordance** (no swipe, popup menu, or button).<br>Seed descriptions contain uncleaned markdown citations. | **Step 2.8:** Add template archive/delete actions with confirmation dialogs and an archived routines filter tab. Clean citation artifacts from seed data. |
| **Template Detail / Start**<br>`WorkoutStartPage-Mobile.png`<br>`WorkoutStartPage-Desktop.png` | Template name + description (`[cite: 4]`)<br>`Revision 1 / PUBLISHED` history badge<br>Full-width green `â–¶ Start workout` button<br>Block card summary (`Arm Blaster / 2 exercises 3 round(s)`)<br>FAB `âœ Edit template` | **Partially Implemented**<br>Can launch session or enter template editor.<br>No delete or archive option in app bar.<br>Does not display exercises, sets, or targets inside the block card. | **Step 2.8:** Add delete/archive action to app bar. Expand block card to show exercise names, target reps, weights, and rest periods. |
| **Active Workout Running**<br>`WorkoutRunningPage-Mobile.png`<br>`WorkoutRunningPage-Desktop.png` | Header with timers: `00:10 ACTIVE`, `00:10 ELAPSED`, Pause button<br>Active Set card with green icon, exercise name, target prescription (`10 reps 30.0 kg`)<br>Set navigation `<` `>` and action buttons (`Log set`, `Edit target`, `Skip`, `Delete`)<br>Collapsible block accordion showing all planned sets<br>Full-width `âœ“ Complete workout` button | **Core Functionality Implemented**<br>State machine, copy-on-write execution, and set logging work reliably. | **Step 13.7:** Add info action/sheet displaying exercise form cues and execution steps during the active set. |
| **Workout Complete Summary**<br>`WorkoutCompletePage-Mobile.png`<br>`WorkoutComplete-Desktop.png` | Top cards: `TOTAL DURATION (â± 00:25)` & `COMPLETED ON (ðŸ“… Nov 2)`<br>Perceived Effort (RPE) slider (`8/10 Hard`)<br>Emoji feeling row (Tired, Neutral, Good, Energetic, Great)<br>Notes text area + green `ðŸ’¾ Save Log` button<br>TIMELINE list shows raw IDs (`exercise-barbell-curl-001`, `exercise-skull-crusher-001`) | **Implemented with Visual Defects**<br>Summary logging, RPE, and notes persist.<br>**Bug:** TIMELINE displays raw IDs instead of resolved exercise names.<br>Missing heart rate input with zone annotation. | Resolve exercise IDs to names in summary timeline. Add average HR input (Phase 18). |
| **Analytics & Progress**<br>`AnalyticsPage-Mobile.png`<br>`AnalyticsPage-Desktop.png` | 10-week workout frequency heatmap (`43 total`)<br>Weekly volume by muscle bar chart<br>"Latest Completed Workouts" card list<br>"Recent Personal Records" list showing raw IDs (`exercise-squat-001`)<br>Desktop layout duplicates "Latest Completed Workouts" section twice | **Implemented with Defects**<br>Projections and charts render real data.<br>**Bug:** Desktop view renders "Latest Completed Workouts" twice.<br>**Bug:** Recent PRs show raw IDs instead of exercise names. | Fix desktop layout duplication. Resolve exercise IDs to names in PR list. Add period filter toggle (`1W \| 1M \| 3M \| YTD`). |
| **Personal Record Trophies**<br>`PRPage-Mobile.png`<br>`PRPage-Desktop.png` | Header: `Achievements (34)`, Sort dropdown (`Newest First`)<br>Filter chips: `All Trophies`, `Max Weight`, `Est. 1RM`, `Max Reps`<br>Trophy list displays raw IDs (`exercise-bench-001`, `exercise-squat-001`) | **Implemented with Defect**<br>Filtering and sorting function correctly.<br>**Bug:** Cards display raw IDs (`exercise-bench-001`) instead of human-readable exercise names. | Resolve exercise IDs to names across the trophy shelf. |
| **Profile & Preferences**<br>`ProfilePage-Mobile.png`<br>`ProfilePage-Desktop.png` | User card: "Athlete / INTERMEDIATE General Strength"<br>Core measurements: Age, Height, Weight<br>Detailed body metrics: Neck, Waist, Hip<br>Unit preferences: KG/LB, KM/MI, CM/FT-IN<br>Training profile & workout execution toggles | **Settings Sub-Screen Only**<br>Full preference and measurement storage works.<br>User display name is uneditable (defaults to "Athlete").<br>**Missing:** Not an onboarding wizard for first launch. | **Step 5.5:** Create 3-step `OnboardingScreen` for first launch. Allow editing display name in profile. |
| **Settings Hub**<br>`SettingsPage-Mobile.png`<br>`SettingsPage-Desktop.png` | Appearance card: App theme, Font size, Font family dropdowns<br>Notifications card: Notification time (`Set time`)<br>Data & Security card: Backup and restore, Authentication type | **Basic Prototype State**<br>Functional, but lacks structure of design specs (`Settings-1.png` / `Settings-2.png`).<br>No profile card header with avatar and edit button.<br>No dedicated Appearance screen (color seed grid, live preview).<br>No Growth Reminders management list.<br>Missing Help & FAQ, About Us, Log Out, and app version. | **Phases 7, 15, 17:** Upgrade settings to grouped hub with profile card, route to Appearance screen (`appRouteAppearance`), route to Reminders screen (`appRouteGrowthReminders`), and add footer actions. |

---

#### 2. Summary of 4 Core Unimplemented Features & Immediate Action Items

1. **Onboarding Page for Capturing User Information (`Step 5.5`):**
   - Implement `OnboardingScreen` featuring the 3-step wizard (`Body Metrics` , `Goals` , `Constraints`).
   - Wire `launch_route_resolver.dart` to check profile existence and divert first-time users before landing on Home.

2. **Dynamic "This Week" Section on Home Dashboard (`Step 7.5`):**
   - Remove hardcoded `3,240 kcal` and `85%` in `week_summary_section.dart`.
   - Stream actual weekly volume, active seconds, and workout counts from `AnalyticsCubit` / `DailySummary`.
   - Calculate calorie expenditure dynamically and wire the "Details" header button to `context.push(appRouteAnalytics)`.

3. **Template Deletion and Archiving (`Step 2.8`):**
   - Expose archive and delete methods in `TemplateBloc` and `ITemplateRepository`.
   - Add archive/delete action buttons and confirmation dialogs in `TemplateListScreen`, `TemplateDetailScreen`, and `TemplateEditorScreen`.
   - Add an "Archived Routines" filter/toggle to `TemplateListScreen` and clean citation artifacts from seed templates.

4. **Steps for Specific Exercises (`Step 13.7`):**
   - Update `ExerciseDetailScreen` to render `setupInstructions` and `executionInstructions` as a sequential, numbered timeline/stepper.
   - Build a custom step builder in `CustomExerciseScreen` allowing users to add, edit, and reorder steps.
   - Provide an in-session step cues sheet during active workout tracking in `ActiveSessionScreen`.

5. **Cross-Screen Visual Fixes (Found in Audit):**
   - **Fix Raw Exercise IDs:** Map document IDs (`exercise-squat-001`) to exercise names in Session Summary Timeline, Analytics PRs, and PR Trophy Shelf.
   - **Fix Desktop Analytics Duplication:** Remove the duplicated "Latest Completed Workouts" section in `AnalyticsDashboardScreen`.


---
