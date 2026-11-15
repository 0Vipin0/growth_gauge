# Phase 18: Fitness Assessment Score & Biometric Intelligence

Calculate and display objective biometric scores and derived training metrics from user profile data and activity history. This phase integrates resting heart rate, training frequency, volume progression, and body measurements into actionable metrics (Composite Fitness Score, Karvonen Heart Rate Zones, BMR/TDEE energy expenditure, and body composition estimates) without external cloud dependencies or medical claims.

---

### 18.1 Mathematical & Physiological Models

#### 1. Karvonen Heart Rate Zones
Calculated dynamically from the user's age and baseline resting heart rate ($\text{HR}_{\text{rest}}$):
- Estimated Maximum Heart Rate: $\text{HR}_{\text{max}} = 220 - \text{Age}$
- Heart Rate Reserve: $\text{HRR} = \text{HR}_{\text{max}} - \text{HR}_{\text{rest}}$
- Target Heart Rate at intensity $I \in [0.5, 1.0]$:
  $$\text{Target HR} = \text{HR}_{\text{rest}} + (\text{HRR} \times I)$$

| Zone | Name | Intensity ($I$) | Physiological Purpose | UI Representation |
|---|---|---|---|---|
| **Zone 1** | Active Recovery | 50% – 60% | Warm-up, post-workout cooldown, active flush | Blue (`#42A5F5`) |
| **Zone 2** | Aerobic Endurance | 60% – 70% | Mitochondrial density, base aerobic capacity | Green (`#00FF66`) |
| **Zone 3** | Tempo & Stamina | 70% – 80% | Aerobic power, sustained moderate intensity | Amber (`#FFB300`) |
| **Zone 4** | Anaerobic Threshold | 80% – 90% | Lactate threshold, high-power stamina | Orange (`#FF5722`) |
| **Zone 5** | Neuromuscular / Max | 90% – 100% | Sprint power, peak anaerobic capacity | Red (`#FF1744`) |

#### 2. Basal Metabolic Rate (BMR) & Daily Energy Expenditure (TDEE)
Calculated via the validated **Mifflin-St Jeor Equation**:
- **Men:** $\text{BMR} = (10 \times \text{weight}_{\text{kg}}) + (6.25 \times \text{height}_{\text{cm}}) - (5 \times \text{age}) + 5$
- **Women:** $\text{BMR} = (10 \times \text{weight}_{\text{kg}}) + (6.25 \times \text{height}_{\text{cm}}) - (5 \times \text{age}) - 161$
- **TDEE:** $\text{TDEE} = \text{BMR} \times \text{ActivityMultiplier}$
  - Sedentary: $1.2$
  - Light Activity: $1.375$
  - Moderate Activity: $1.55$
  - Heavy Activity: $1.725$
  - Athletic / Extreme: $1.9$

#### 3. Composite Fitness Assessment Score (0 – 100)
A holistic, dynamic index aggregating 4 weighted pillars:
$$\text{Score} = (0.35 \times S_{\text{consistency}}) + (0.25 \times S_{\text{cardio}}) + (0.25 \times S_{\text{volume}}) + (0.15 \times S_{\text{progression}})$$
- **Consistency ($S_{\text{consistency}}$):** 28-day adherence against weekly workout goal (0–100).
- **Cardiovascular Health ($S_{\text{cardio}}$):** Baseline Resting HR rated against age-adjusted athletic norms (e.g., 40–50 bpm = 100, >80 bpm = 40).
- **Training Volume ($S_{\text{volume}}$):** Total monthly tonnage progression vs. personal historical baseline.
- **Progression ($S_{\text{progression}}$):** Frequency of personal records or 1RM increases within 60 days.

#### 4. Body Composition (U.S. Navy Body Fat Method)
Derived when optional `neckCm`, `waistCm`, and `hipCm` measurements are provided:
- **Men:** $\% \text{Fat} = 495 / (1.0324 - 0.19077 \log_{10}(\text{waist} - \text{neck}) + 0.15456 \log_{10}(\text{height})) - 450$
- **Women:** $\% \text{Fat} = 495 / (1.29579 - 0.35004 \log_{10}(\text{waist} + \text{hip} - \text{neck}) + 0.22100 \log_{10}(\text{height})) - 450$

---

### 18.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 18.1** | Biometric calculation utility models | `[ ] PLANNED` | Implement Karvonen HR zones, Mifflin-St Jeor BMR/TDEE, and Navy body fat algorithms with pure, deterministic unit tests. |
| **Step 18.2** | Composite Fitness Score calculation use case | `[ ] PLANNED` | Aggregate historical session logs, resting HR, and 1RM trends from Drift read tables to compute the 0–100 score. |
| **Step 18.3** | Average Heart Rate session logging & Zone derivation | `[ ] PLANNED` | Update `SessionSummaryScreen` with an Average HR input and live "Zone N • Name" pill indicator. |
| **Step 18.4** | HR & TDEE presentation in Profile & Trends | `[ ] PLANNED` | Display HR Zone breakdown card and TDEE calorie estimate in `ProfileScreen`. Add average HR trend chart to `AnalyticsDashboardScreen`. |
| **Step 18.5** | Fitness Score gauge widget on Home | `[ ] PLANNED` | Build an interactive score radial gauge / card displaying the composite index on the training dashboard. |
| **Step 18.6** | Biometric intelligence regression tests | `[ ] PLANNED` | Comprehensive tests for edge cases (zero RHR, missing circumferences, extreme inputs) and boundary values. |

---

### 18.3 Acceptance Criteria
- Karvonen and Mifflin-St Jeor calculations produce deterministic, unit-tested values matching published physiological standards.
- Average HR inputs in workout completion automatically resolve to the correct personal training zone.
- Missing optional measurements (neck/waist/hip) degrade gracefully without breaking scoring or profile flows.
- Automated tests verify formulas, rounding, and null handling; `scripts/check.ps1` passes.

