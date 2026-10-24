# Skill: State Management

## Purpose

Implement application state consistently with the project's existing
state-management architecture.

## Procedure

Determine the existing state-management approach.

Understand:

- State ownership
- State lifecycle
- Async state
- Loading states
- Error states
- Empty states
- Success states
- Event/action patterns
- Dependency access
- Disposal

## Rules

Do not introduce another state-management framework.

Do not mix patterns without justification.

Keep business logic out of widgets when the project separates it.

Avoid complex state management for trivial local state.

Follow the project's existing state naming and organization.

## Validation

Confirm that the new state implementation resembles existing
state implementations in structure, lifecycle, and dependency usage.
