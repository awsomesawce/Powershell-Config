# Rewrite of the Powershell profile

# Environment Variables
$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:PAGER = "less"
$env:PATH = "C:/Users/Carl/bin;$env:PATH"

# Edit PSModulePath
$env:PSModulePath = @(
    (Join-Path $PSScriptRoot 'MyModules')
    $env:PSModulePath
) -join [IO.Path]::PathSeparator

# Dot-source functions
. "$psscriptroot/functions/Get-ProjectDirectory.ps1"

# Moved Get-InstalledThemes to MyUtils module

$Script:msyslocation = "$env:USERPROFILE\scoop\apps\msys2\current"

New-Alias -Name msysshell -Value "$msyslocation\msys2_shell.cmd" -Description "msys2_shell.cmd alias"

New-Alias chtsh $env:USERPROFILE\Documents\BASICS\getChtsh.ps1 `
    -Description "Chtsh function"

# TODO: Move module to $env:PSModulePath
Import-Module $env:USERPROFILE/Documents/BASICS/SearchTools/SearchTools.psd1

new-alias g git -Description "Super short git invokation ftw.  1/3 the length!"

# Extra completions
(&mise activate pwsh) | out-string | Invoke-Expression
(&gh completion --shell powershell) | out-string | Invoke-Expression
(&mise completions pwsh) | out-string | Invoke-Expression
(&aube completion powershell) | out-string | Invoke-Expression

# Prompt
if (Get-Command oh-my-posh -ErrorAction Ignore) {
    oh-my-posh init pwsh --config 'tokyonight_storm' |
        Invoke-Expression
}
