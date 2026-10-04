# Skill: Architecture Discovery

## Purpose

Identify the actual architectural model used by the project.

## Use When

Apply before:

- Creating major features.
- Introducing infrastructure.
- Refactoring architecture.
- Adding a new architectural abstraction.
- Changing data flow.

## Procedure

Determine:

1. Presentation boundaries.
2. Application/business-logic boundaries.
3. Domain boundaries, if present.
4. Data boundaries.
5. Infrastructure boundaries.
6. Dependency direction.
7. State ownership.
8. Dependency injection.
9. Shared-code boundaries.

Determine whether the project resembles:

- Feature-first
- Layer-first
- Clean Architecture
- MVVM
- BLoC
- Riverpod
- Provider
- Repository-based
- Service-oriented
- Custom/hybrid

Do not classify the project merely for classification.

The purpose is to understand its actual boundaries.

## Rules

Do not impose a standard architecture.

Do not create layers solely because another architecture recommends them.

Architecture should be inferred from actual project behavior.

## Expected Outcome

Produce an internal architecture map sufficient to implement
new functionality consistently.
    