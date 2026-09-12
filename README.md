# Powershell Config

Here is where my current configuration for [PowerShell] lives.

## What's Included

- `Get-InstalledThemes` - Gets a list of themes installed by [Oh-My-Posh]
- `which` - a wrapper around Get-Command which simply returns the location of the command.

### Modules

* `Formatters` - Contains PowerShell filters for transforming command output.
  * `Format-ScoopInfo` - A pipeline filter that formats `scoop info` output as a Markdown list item containing the package name, website, and description.

* `ScoopCompletions` - A module that finds completion scripts for programs installed by [Scoop]. See my post about it [here][Post about ScoopCompletions].
* `MyUtils` - A module that contains a few utility functions (for now).
  * `Select-OmpTheme` - Use `fzf` to switch between [Oh-My-Posh] themes.


## What's Not Included

Some modules and commands which are referenced in this profile are not included in this GitHub repository.

- SearchTools - Contains `Invoke-Search` which allows me to open a search in the browser from the command line.
- chtsh - use Invoke-RestMethod to request cheatsheets from https://cheat.sh

## Future Plans

- [ ] Include the functionality mentioned in _What's Not Included_.
- [ ] Add more convenience functions.
- [ ] Move ScoopCompletions into its own repository.

I use [Oh-My-Posh] as my prompt of choice. Install it using `winget install JanDeDobbeleer.OhMyPosh` or `scoop install oh-my-posh`

[PowerShell]: https://github.com/PowerShell/PowerShell
[Oh-My-Posh]: https://ohmyposh.dev
[Scoop]: https://scoop.sh
[Post about ScoopCompletions]: https://dev.to/awsomesawce/powershell-completions-installed-by-scoop-1pnd
