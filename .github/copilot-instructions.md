# Copilot instructions

## Excluded directories

Do not read, inspect, search, index, summarize, modify, or execute files under these repository directories:

- `/Help/`
- `/Modules/`
- `/Scripts/`

These directories contain PowerShell content installed by `Install-Module` and are intentionally excluded from source review. Treat them as out of scope even if a task appears to involve their contents. Base analysis and changes only on files outside these directories unless the user explicitly overrides this instruction and asks for a specific file or directory.
