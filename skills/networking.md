# Skill: Networking

## Purpose

Implement network functionality using the project's existing
networking architecture.

## Procedure

Discover:

- HTTP client
- API abstraction
- Authentication
- Interceptors
- Serialization
- Error handling
- Retry behavior
- Pagination
- Caching

Then follow the existing implementation.

## Rules

Do not assume a particular networking library.

Do not introduce another HTTP abstraction unnecessarily.

Do not place network calls directly in UI code when the project
has a separate data layer.

Reuse existing authentication and error-handling infrastructure.
