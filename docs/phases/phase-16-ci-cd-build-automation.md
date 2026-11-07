## 19. Phase 16: GitHub Actions Build Improvements

Review and improve CI and release automation using the repository's existing scripts as the source of truth. The current workflows duplicate check commands, pin different Flutter versions (`3.29.1` for pull requests and `3.38.4` for releases) below the project's declared Flutter minimum (`>=3.44.0`), limit pull request checks to `main`, and maintain separate release build/artifact upload logic. The target is consistent, secure, reproducible checks and clear release artifacts across supported platforms.

### 16.1 CI/CD Rules

- Align Flutter/Dart versions with `pubspec.yaml` and local scripts, preferably through one documented version source; avoid silently testing with an older SDK than the project requires.
- Reuse `scripts/check` (or its documented equivalent) for analysis, format verification, and tests so local and CI behavior agree. Run code generation only when required and fail if generated source is stale rather than rewriting files invisibly.
- Run checks for pull requests and relevant branch pushes, including forks where safe. Never expose release-signing secrets to untrusted PR code. Use concurrency cancellation for superseded checks when it does not interrupt a release.
- Separate fast validation from platform builds where that improves feedback. Use a deliberate matrix for supported targets and install only platform build prerequisites in the corresponding jobs.
- Minimize workflow and job token permissions; pin third-party actions to immutable commit SHAs where repository policy permits and document the update mechanism. Keep caches scoped and treat them as performance aids, not correctness inputs.
- Make release builds tag-driven and reproducible, upload artifacts with explicit names/retention, validate artifact existence, and publish a release only after all required builds succeed. Keep signing secrets out of non-release jobs and avoid deprecated release steps.
- Document supported build targets, required secrets, versioning/tag conventions, and how to reproduce failures locally. Do not add deployment or publishing targets beyond the project's stated release needs.

### 16.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 16.1** | Inventory workflows, scripts, targets, and secrets | `[ ] PLANNED` | Map triggers, Flutter/JDK versions, platform dependencies, release permissions, signing secrets, artifacts, and duplicated commands. |
| **Step 16.2** | Define CI version and validation source of truth | `[ ] PLANNED` | Align SDK/tooling with `pubspec.yaml`; route CI checks through the same validation scripts used locally. |
| **Step 16.3** | Improve pull request validation | `[ ] PLANNED` | Add appropriate branch/push coverage, safe fork behavior, concurrency, caching, least-privilege permissions, and clear job summaries. |
| **Step 16.4** | Refactor platform release builds and artifacts | `[ ] PLANNED` | Simplify the build matrix, separate secret-free builds from signing, verify artifact names/paths, and publish only after all required jobs pass. |
| **Step 16.5** | Harden actions, secrets, and maintenance | `[ ] PLANNED` | Review action pinning/update policy, secret exposure, release token scope, and replacement of deprecated release actions. |
| **Step 16.6** | Validate and document CI behavior | `[ ] PLANNED` | Validate workflow syntax and build/check commands, document local reproduction and release requirements, and review action permissions/security. |

### 16.3 Acceptance Criteria

- Pull request checks use the project-supported Flutter version and the same core validation commands developers run locally.
- Release builds cover the declared supported platforms, preserve signing secrets for trusted release jobs only, and publish complete artifacts only after required builds pass.
- Workflow permissions are minimal, action versions have a maintainable pin/update policy, and caches do not hide failed or stale validation.
- Workflow changes are syntax-validated and documented, and local scripts can reproduce the checks needed to diagnose CI failures.

---
