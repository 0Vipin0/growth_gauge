# Skill: Data Layer

## Purpose

Implement data access consistently with the project's architecture.

## Discover

Determine whether the project uses:

- Repositories
- Services
- Data sources
- API clients
- DTOs
- Domain entities
- Mappers
- Persistence layers

## Procedure

1. Find similar data flows.
2. Reuse existing clients.
3. Follow existing repository boundaries.
4. Follow model/DTO conventions.
5. Follow serialization conventions.
6. Follow error-mapping conventions.
7. Add only the layers that the project actually uses.

## Rules

Do not create unnecessary layers.

Do not access infrastructure directly from presentation code
when the architecture separates them.

Do not introduce a second data-access pattern.
