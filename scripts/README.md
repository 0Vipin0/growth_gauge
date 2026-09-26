# Development scripts

Run the `.ps1` files in PowerShell or the `.sh` files in Bash. They locate the project root automatically, so they can be invoked from any directory.

| Script | Purpose |
|---|---|
| `./scripts/setup.ps1` | Fetch Flutter dependencies. |
| `./scripts/check.ps1` | Run the same analysis, formatting, and test checks used by pull request CI. |
| `./scripts/generate.ps1` | Regenerate Freezed, JSON serialization, and Drift code. |
| `./scripts/run.ps1` | Run the app; forward optional Flutter arguments such as `-d windows`. |
| `./scripts/build.ps1 windows` | Build for a target platform (`apk`, `appbundle`, `web`, `windows`, `linux`, or `macos`). |

Matching Bash scripts are available as `setup.sh`, `check.sh`, `generate.sh`, `run.sh`, and `build.sh`.

Examples:

```powershell
./scripts/run.ps1 -d windows
./scripts/build.ps1 apk --split-per-abi
```

On Linux or macOS:

```bash
bash scripts/setup.sh
bash scripts/check.sh
bash scripts/generate.sh
bash scripts/run.sh -d linux
bash scripts/build.sh apk --split-per-abi
```

The generation script uses `--delete-conflicting-outputs`, matching the normal build_runner recovery workflow. Review generated changes with Git after running it.
