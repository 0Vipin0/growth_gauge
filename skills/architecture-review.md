# Skill: Architecture Review

## Purpose

Detect architectural drift and unnecessary complexity.

## Review

### Architecture

- Does the change follow the existing architecture?
- Are dependencies flowing correctly?
- Were unnecessary layers introduced?

### Features

- Are feature boundaries clear?
- Was shared code introduced unnecessarily?

### State

- Is existing state management being used?

### Data

- Is existing networking/data infrastructure being used?

### UI

- Are existing components being reused?

### Navigation

- Is existing routing being used?

### Dependencies

- Were unnecessary packages added?

### Testing

- Is behavior adequately tested?

## Drift Indicators

Look for:

- Competing frameworks
- Duplicate infrastructure
- Duplicate abstractions
- Bypassed architecture boundaries
- New global utilities
- Business logic in UI
- Inconsistent feature structure
- Unnecessary dependencies
- Unrelated refactoring

## Outcome

Classify the result as:

- Consistent
- Minor inconsistency
- Architectural concern
- Architectural change required

Provide corrective recommendations when necessary.
