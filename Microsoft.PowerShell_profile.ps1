# Rewrite of the Powershell profile

# Environment Variables
$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:PAGER = "less"
$env:OLDPATH = $env:PATH.Clone()
$env:PATH = "C:/Users/Carl/bin;$env:PATH"

# Edit PSModulePath
$env:PSModulePath = @(
    (Join-Path $PSScriptRoot 'MyModules')
    $env:PSModulePath
) -join [IO.Path]::PathSeparator

# Dot-source functions
. "$psscriptroot/functions/Get-ProjectDirectory.ps1"


function Get-InstalledThemes {
    <#
    .SYNOPSIS
    Get installed oh-my-posh themes.
    .DESCRIPTION
    Gets installed oh-my-posh themes from default location.
    #>
    [CmdletBinding()]
    param()

    if (Test-Path $env:POSH_THEMES_PATH) {
        Get-ChildItem $env:POSH_THEMES_PATH -ea SilentlyContinue
    }
    else {
        Write-Error "Did not find oh-my-posh themes at $env:POSH_THEMES_PATH"
    }

}

function which {
    <#.SYNOPSIS
    Just like unix which.  Returns only a string.
    .DESCRIPTION
    A wrapper around `Get-Command` which returns the location of the command as a string.
    .PARAMETER cmdname
    Name of command to look up.
    .PARAMETER All
    Return all that match cmd name
    .NOTES
    Only works on installed applications or commands which live in a file.
    #>
    param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Name of command")]
        [string]$CommandName,

        [Parameter(Position = 1, HelpMessage = "Show all locations of a given command")]
        [Alias("-a")]
        [switch]$All
    )

    if ($All) {
        Write-Debug "DEBUG: Get all commands matching $CommandName"
        return Get-Command -Name $CommandName -All | Select-Object -ExpandProperty Path
    }
    return (get-command $CommandName).Path.ToString()
}

# TODO: Change or remove Prepare-Pipenv
new-alias Prepare-Pipenv C:\Users\Carl\Documents\virt_env_test\pipenv_test\preparepipenv.ps1 -Description @"
Adds location of ``pipenv`` to `$PATH
"@ -Option None -Scope Local

$Script:msyslocation = "C:\Users\Carl\scoop\apps\msys2\current"

New-Alias -Name msysshell -Value "$msyslocation\msys2_shell.cmd" -Description "msys2_shell.cmd alias"

New-Alias chtsh C:\Users\Carl\Documents\BASICS\getChtsh.ps1 `
    -Description "Chtsh function"

# TODO: Move module to $env:PSModulePath
Import-Module $env:USERPROFILE/Documents/BASICS/SearchTools/SearchTools.psd1

new-alias g git -Description "Super short git invokation ftw.  1/3 the length!"

Set-Alias pn pnpm
Set-Alias fe ForEach-Object
Set-Alias sel Select-Object

oh-my-posh init pwsh --config tokyonight_storm | invoke-expression
