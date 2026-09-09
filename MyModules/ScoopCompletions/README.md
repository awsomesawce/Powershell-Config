# ScoopCompletions

## What is it

ScoopCompletions is a PowerShell module that provides tab completion for scoop-installed apps.
It scans directories in the ~/scoop/apps directory and finds powershell scripts which start with an underscore.
It then dot-sources them to provide the tab completion.

## Why

Some of these scoop-installed apps come with completion scripts baked into their installation, but for some reason they are not automatically loaded into your PowerShell profile. This module provides a way to source them programmatically.

## How to use

```powershell
Import-Module ScoopCompletions
Enable-ScoopCompletions
```
