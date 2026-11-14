## 17. Phase 14: Secure Local Authentication

Complete the existing local authentication flow with platform biometrics (including fingerprint where supported) and a PIN fallback. At setup and app launch/resume, check the device's actual biometric and secure-lock capabilities. When biometrics are unavailable or not enrolled, offer PIN setup and use PIN authentication; when a biometric attempt is cancelled or fails, keep an explicit PIN fallback available. Authentication must remain local and must not block access to recovery of the configured credential.

### 14.1 Authentication Rules

- Use the platform authentication prompt through `local_auth`; check biometric availability/type and device support, not only the presence of a biometric sensor. Distinguish unsupported, not enrolled, temporarily unavailable, cancelled, and failed outcomes for clear UI fallback.
- Keep biometric templates and device credentials with the operating system. The app stores no biometric data and does not implement its own fingerprint matching.
- Never persist a raw PIN. Store a salted verifier using a suitable password-based derivation approach and secure storage; do not log PINs or authentication secrets. Define a minimum PIN policy and failed-attempt throttling/lockout behavior that does not create an unrecoverable local account.
- Provide a PIN route when biometric authentication is absent, unsupported, opted out, cancelled, or unavailable. Biometric failure must not silently authenticate or permanently prevent the user from selecting PIN.
- Apply the lock policy consistently at cold launch and configured resume points, preserve secure navigation/back-stack behavior, and avoid exposing protected screens while authentication is pending.
- Provide an explicit way to change/reset local authentication settings with re-authentication or a clear local recovery policy. Explain that local app lock is a device-level privacy feature, not a remote account or cloud identity.

### 14.2 Execution Status

| Step | Action | Status | Notes |
|---|---|---|---|
| **Step 14.1** | Audit platform capability and current auth flows | `[ ] PLANNED` | Verify biometric types, device credential support, secure storage behavior, launch/resume routes, and supported platform differences. |
| **Step 14.2** | Define auth policy and fallback states | `[ ] PLANNED` | Specify PIN setup/validation, biometric opt-in, cancellation/failure fallback, lock timing, retry limits, and reset behavior. |
| **Step 14.3** | Harden PIN storage and validation | `[ ] PLANNED` | Replace raw PIN comparison/storage with a salted verifier, secure storage, input validation, and bounded failed-attempt handling. |
| **Step 14.4** | Complete biometric and PIN flows | `[ ] PLANNED` | Wire setup, capability checks, launch/resume gate, explicit fallback, settings, and correct route-stack behavior. |
| **Step 14.5** | Add authentication regression tests | `[ ] PLANNED` | Cover supported/unavailable/not-enrolled/cancelled/failed biometrics, PIN success/failure/throttling, and protected-route gating with platform fakes. |
| **Step 14.6** | Validate platform behavior and document limits | `[ ] PLANNED` | Run supported-device checks, permission/platform configuration review, security review, and project validation. |

### 14.3 Acceptance Criteria

- Biometric authentication is offered only when the platform reports it usable; PIN remains available when biometric authentication is absent or unsuccessful.
- The PIN is never stored or logged in raw form; secure storage, verifier comparison, retry throttling, and reset behavior have tests and documented policy.
- Protected routes remain inaccessible until authentication succeeds, while users can recover from biometric cancellation/failure through the PIN path.
- Tests cover expected platform capability and failure outcomes, and target-device checks verify system prompts and lifecycle behavior on supported platforms.

---
