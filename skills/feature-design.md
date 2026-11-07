# Skill: Feature Design

## Purpose

Design features that fit naturally into the project's architecture.

## Procedure

1. Understand the feature requirements.
2. Discover the project architecture.
3. Find the closest existing feature.
4. Compare feature structures.
5. Identify reusable components.
6. Identify existing infrastructure.
7. Define the feature boundary.
8. Define data flow.
9. Define state ownership.
10. Define navigation requirements.
11. Define testing requirements.
12. Define the smallest implementation.

## Rules

Feature-specific concerns should remain inside the feature unless
they are genuinely reusable.

Do not create global abstractions merely to avoid duplication.

Do not introduce a new architecture for one feature.

## Validation

Before implementation, verify:

- Feature boundary is clear.
- Existing patterns are being reused.
- No unnecessary infrastructure is being introduced.
- Data and state responsibilities are clear.
