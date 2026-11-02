## 15. Phase 12: Responsive and Accessible Experience

Adapt the existing screens for mobile phones, tablets, and laptop/desktop windows while making accessibility behavior consistent across those form factors. Use available width, height, and input capabilities to choose layouts; do not assume that a device category always has a fixed size or orientation. Preserve the current visual language and feature flows while improving constraints, navigation, keyboard use, and semantics.

### 12.1 Experience Rules

- Use constraint-driven breakpoints and reusable responsive layout components; avoid hard-coded device model checks and duplicated screen implementations.
- Define supported layout classes for compact, medium, and expanded windows. On expanded layouts, use the extra space deliberately (for example, constrained content widths, adaptive navigation, or two-pane detail flows) rather than stretching phone layouts across the screen.
- Verify portrait and landscape behavior, window resizing, text scaling, safe areas, scrolling, and dialogs/sheets at representative viewport sizes.
- Support touch targets and gestures on mobile, keyboard navigation and focus traversal on laptop/desktop, and adaptive input affordances where mouse/keyboard are available.
- Apply semantic labels/roles/order, visible focus, sufficient contrast, scalable text, and reduced-motion-aware transitions. Respect platform accessibility settings where Flutter exposes them.
- Settings must support the legacy-requested theme and font customization where compatible with the current app. Preserve settings across restarts if supported by the existing settings model; do not introduce a new architecture for this feature.
- Keep breakpoints and shared responsive primitives in the existing presentation/common or app theme boundary only when they are genuinely reused; avoid speculative design-system layers.

### 12.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 12.1** | Audit current layouts and accessibility gaps | `[x] COMPLETED` | Reviewed core journeys and applied bounded content layouts, scroll and control sizing, and semantic improvements where the audit found gaps. |
| **Step 12.2** | Define responsive layout and navigation rules | `[x] COMPLETED` | `AppWindowSizeClass` uses compact below 600 px, medium from 600 to 1024 px, and expanded from 1024 px; Home adapts navigation at those constraints. |
| **Step 12.3** | Add reusable adaptive layout primitives | `[x] COMPLETED` | Added shared `ResponsiveContent` and reused the existing form layout convention for bounded forms. |
| **Step 12.4** | Adapt high-priority application journeys | `[x] COMPLETED` | Applied responsive constraints to launch/auth, Home, active workout, catalog/template, analytics, profile, settings, user screens, and backup/restore. |
| **Step 12.5** | Improve keyboard, semantics, contrast, and scaling | `[x] COMPLETED` | Added/retained meaningful semantics, keyboard submission and activation coverage, resize-safe navigation state, reduced-motion-aware page changes, and large-text layout checks; existing contrast coverage remains in place. |
| **Step 12.6** | Add viewport/accessibility regression checks | `[x] COMPLETED` | Widget tests cover compact/medium/expanded navigation, content widths, 200% text scaling, semantics, keyboard activation, and chart descriptions. Manual device and assistive-technology checks are documented in `docs/responsive-accessibility-checks.md` and still require execution on target devices. |

The Phase 12 implementation passes `scripts/check.ps1` (analysis, format verification, and full test suite). The documented platform/device checklist has not been manually executed; keep the phase in progress until that review is completed.

### 12.3 Acceptance Criteria

- Core journeys render without overflow or clipped actions at representative phone, tablet, and laptop viewport sizes, including resized windows and large text.
- Expanded layouts use available space intentionally while compact layouts preserve usable controls and clear navigation.
- Important actions are reachable by touch and keyboard, expose meaningful semantics and focus, and meet the repository's contrast/accessibility criteria.
- Automated widget checks cover responsive states and documented manual checks cover platform/device behavior that cannot be reliably automated; `scripts/check.ps1` passes.

---
