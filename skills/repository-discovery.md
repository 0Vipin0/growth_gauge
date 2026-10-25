# Skill: Repository Discovery

## Purpose

Build an accurate understanding of a Flutter/Dart repository before
making significant changes.

## Use When

Apply this skill when:

- Starting work in an unfamiliar repository.
- Entering an unfamiliar part of the codebase.
- Architecture is unclear.
- Project conventions are unclear.
- A significant feature is being introduced.
- An architectural decision is required.

## Discovery Areas

Inspect enough of the repository to determine:

### Project

- Flutter version
- Dart version
- Package configuration
- Build configuration
- Linting
- Formatting
- Code generation

### Architecture

- Feature organization
- Layer organization
- Dependency direction
- Business-logic boundaries
- Shared/core boundaries

### State

- State-management solution
- State ownership
- Async state handling
- Lifecycle management

### Data

- Networking
- Repositories
- Data sources
- Models
- DTOs
- Entities
- Serialization
- Persistence
- Error handling

### Application Infrastructure

- Dependency injection
- Navigation
- Configuration
- Environment handling
- Authentication
- Logging
- Analytics

### UI

- Design system
- Theme
- Components
- Typography
- Spacing
- Responsive behavior
- Accessibility

### Testing

- Unit tests
- Widget tests
- Integration tests
- Golden tests
- Mocking/fakes
- Test organization

## Procedure

1. Inspect project configuration.
2. Inspect the top-level source structure.
3. Inspect representative features.
4. Inspect shared infrastructure.
5. Inspect tests.
6. Identify dominant patterns.
7. Identify notable exceptions.
8. Determine which patterns appear legacy.
9. Build an internal architecture map.

## Rules

Do not assume an architecture from folder names.

Do not treat one implementation as representative without checking
additional examples.

Prefer current, actively maintained patterns over obvious legacy code.

Do not modify code during discovery unless explicitly requested.

## Expected Outcome

You should be able to explain:

- How the application is organized.
- How data flows through it.
- Where business logic lives.
- How state is managed.
- How dependencies are provided.
- How navigation works.
- How UI is structured.
- How code is tested.
