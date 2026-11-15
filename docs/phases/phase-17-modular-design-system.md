## 20. Phase 17: Unified Design System, Modular Widget Library & Adaptive Theme Engine

Create a cohesive, accessible, and responsive design system for Growth Gauge. This phase replaces fragmented and hardcoded UI patterns (such as conflicting purple color schemes in `theme_config.dart`, ad-hoc text fields, and inconsistent card paddings) with a unified design system. The system combines Material 3 dynamic color generation with a curated fitness seed palette, centralized typography (Manrope, Open Dyslexic, System Default), WCAG 2.1 AA/AAA accessibility compliance, and a library of modular, responsive components in `lib/features/common/presentation/widgets/`.

### 17.1 Architectural & Design-System Rules

1. **Color Engine & Curated Seed Palettes:**
   - Deprecate hardcoded purple color constants in `theme_config.dart`. Generate dynamic light, dark, medium-contrast, and high-contrast `ColorScheme` instances using `ColorScheme.fromSeed` anchored by 8 curated fitness seeds:
     - **Forest (Default):** Vibrant athletic green (`0xFF00FF66` dark / `0xFF008732` light)
     - **Midnight:** Deep electric indigo (`0xFF5C6BC0`)
     - **Amber:** High-visibility power yellow/amber (`0xFFFFB300`)
     - **Slate:** Cool metallic minimalist grey (`0xFF78909C`)
     - **Rust:** Fiery sprint orange (`0xFFFF5722`)
     - **Moss:** Natural organic sage green (`0xFF4CAF50`)
     - **Cyan:** Hyper-electric endurance cyan (`0xFF00E5FF`)
     - **Custom:** User-selected hex color harmonized via HCT color space
   - Surfaces must strictly use Material 3 tonal elevation containers (`surfaceContainerLowest`, `surfaceContainerLow`, `surfaceContainer`, `surfaceContainerHigh`, `surfaceContainerHighest`).

2. **Typography Engine:**
   - Centralize typography on three verified font families:
     - **Manrope (Default):** Modern geometric sans-serif optimized for numbers, fitness metrics, and clean headers.
     - **Open Dyslexic:** High-readability font designed to mitigate common reading errors and visual crowding.
     - **System Default:** Native platform sans-serif (San Francisco on iOS/macOS, Roboto on Android, Segoe UI on Windows).
   - Base all text styles on `Theme.of(context).textTheme` semantic roles. Support continuous font scaling via `MediaQuery.textScalerOf(context)` without clipping or fixed-height overflow.

3. **Accessibility (A11y) & WCAG Compliance:**
   - **Contrast Ratio:** Enforce minimum 4.5:1 for normal text and 3:1 for large text / graphical controls in standard modes; enforce 7:1 (AAA) in High Contrast mode.
   - **Touch Targets:** All interactive controls must guarantee a minimum hit region of 48Ã—48 dp (`kMinInteractiveDimension`).
   - **Focus & Keyboard Navigation:** Desktop and tablet keyboards must show a high-visibility 2 dp primary accent outline with 2 dp offset on active elements.
   - **Screen Reader Semantics:** Active timers, set counts, completion dialogs, and charts must provide descriptive semantic labels, hints, and live-region announcements (`SemanticsService.announce`).
   - **Reduced Motion:** When `MediaQuery.disableAnimationsOf(context)` is enabled, animations (progress rings, transitions, charts) immediately snap to end values without spring or lerp effects.

4. **Responsive & Adaptive Layout Hierarchy:**
   - Window size classes:
     - **Compact (< 600 dp):** Mobile phones. Bottom navigation bar, single-column scrollable lists, full-width modal sheets.
     - **Medium (600â€“1024 dp):** Tablets and foldables. Left navigation rail, 2-column card grids, persistent side sheets.
     - **Expanded (â‰¥ 1024 dp):** Desktop and large tablets. Extended navigation rail, 3-column catalog grids, max-width bounded content containers (Dashboards: 1080 dp, Forms: 760 dp, Detail views: 900 dp).

5. **Modular Widget System (`features/common/presentation/widgets/`):**
   - Provide standard composable UI primitives:
     - `AppButton`: Primary (filled accent), Secondary (tonal), Outlined, Ghost/Text, Destructive, and Transport (play/pause/skip).
     - `AppTextField`: Standardized dark input with floating label, prefix/suffix icons, character counter, error text, and unit labels.
     - `AppDropdown<T>`: Uniform dropdown with search filtering and bottom-sheet fallback on compact viewports.
     - `AppCard`: Standard 16 dp rounded container with `surfaceContainer` fill and optional selected state border.
     - `AppSegmentedControl<T>`: Pill toggle control with sliding active indicator.
     - `AppStatCard`: Metric tile featuring icon container, value, title, and trend indicator.
     - `AppProgressRing`: Vector circular progress ring for calories, daily goal completion, and time caps.
     - `AppActivityBadge`: Circular icon pill indicating block types (Warm Up, Interval, Reps, Rest, Cool Down).

### 17.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 17.1** | Audit theme, colors, and reconcile `FitnessTheme` | `[ ] PLANNED` | Remove obsolete purple schemes in `theme_config.dart`. Implement 8 curated seed palettes (Forest, Midnight, Amber, Slate, Rust, Moss, Cyan, Custom) with dynamic light/dark/contrast modes in `FitnessTheme`. |
| **Step 17.2** | Implement centralized typography engine | `[ ] PLANNED` | Wire `Manrope`, `Open Dyslexic`, and `System Default` into `AppFontTheme` using standard `TextTheme` roles, responsive line heights, and `TextScaler` support. |
| **Step 17.3** | Build core form controls (`AppTextField`, `AppDropdown`, `AppButton`) | `[ ] PLANNED` | Implement modular inputs in `lib/features/common/presentation/widgets/` with 48 dp touch targets, floating labels, validation states, and visible focus. |
| **Step 17.4** | Build data display components (`AppCard`, `AppProgressRing`, `AppStatCard`, `AppActivityBadge`) | `[ ] PLANNED` | Implement standardized cards, vector progress rings for calories/time caps, stat tiles, and block activity category badges. |
| **Step 17.5** | Implement dedicated Appearance screen (`appRouteAppearance`) | `[ ] PLANNED` | Build the screen from `Settings-2.png`: Light/Dark/System toggle, 8-swatch seed grid, font family selector, text size slider, and live preview card updating in real time. |
| **Step 17.6** | Screen migration and design system regression tests | `[ ] PLANNED` | Migrate Home, Catalog, Template, Session, and Settings to use the modular widgets. Add automated tests covering WCAG AA contrast, text scaling up to 200%, keyboard focus traversal, and responsive window resizing. |

### 17.3 Acceptance Criteria

- All screens share a consistent visual language: near-black green surfaces (`#0E1410`), accent green (`#00FF66`), 16 dp rounded cards, and clean typography.
- Users can switch between 8 seed palettes, 3 font families, and continuous text scale in Appearance settings with instantaneous preview.
- All controls pass WCAG 2.1 AA contrast requirements and touch targets measure at least 48Ã—48 dp.
- Layouts adapt seamlessly across Compact (<600 dp), Medium (600â€“1024 dp), and Expanded (â‰¥1024 dp) breakpoints without clipped text or RenderFlex overflows.
- Hardcoded literals, duplicate text fields, and inconsistent card decorations are replaced by shared modular widgets.


---
