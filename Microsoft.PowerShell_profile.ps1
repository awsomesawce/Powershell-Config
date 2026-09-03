# Rewrite of the Powershell profile

# ENVVARS

$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:PAGER = "less"
$env:OLDPATH = $env:PATH.Clone()

$env:PATH = "C:/Users/Carl/bin;$env:PATH"


function Get-InstalledThemes {

    <#
.DESCRIPTION
Gets installed oh-my-posh themes from scoop installed omp.
#>

    [cmdletbinding()]
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
    .PARAMETER cmdname
    Name of command to look up.
    .PARAMETER All
    Return all that match cmd name
    #>
    param(
        [Parameter(Position = 0, HelpMessage = "Name of command to look up.")]
        [string]$cmdname,

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true, HelpMessage = "ShowAll")]
        [Alias("-a")]
        [switch]$All
    )

    if ($All) {
        Write-Debug "DEBUG: ALL"
        return gcm -All $cmdname | Select-Object -ExpandProperty Path
    }
    return (get-command $cmdname).Path.ToString()
}


new-alias Prepare-Pipenv C:\Users\Carl\Documents\virt_env_test\pipenv_test\preparepipenv.ps1 -Description @"
Adds location of ``pipenv`` to `$PATH
"@ -Option None -Scope Local

$Script:msyslocation = "C:\Users\Carl\scoop\apps\msys2\current"

New-Alias -Name msysshell -Value "$msyslocation\msys2_shell.cmd" -Description "msys2_shell.cmd alias"

New-Alias chtsh C:\Users\Carl\Documents\BASICS\getChtsh.ps1 `
    -Description "Chtsh function"

Import-Module $env:USERPROFILE/BASICS/SearchTools/SearchTools.psd1

new-alias g git -Description "Super short git invokation ftw.  1/3 the length!"


Set-Alias pn pnpm
Set-Alias fe ForEach-Object
Set-Alias sel Select-Object

oh-my-posh init pwsh --config C:\Users\Carl\scoop\apps\oh-my-posh\current\themes\sonicboom_dark.omp.json | invoke-expression
