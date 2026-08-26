# Rewrite of the Powershell profile

# ENVVARS

$env:POWERSHELL_TELEMETRY_OPTOUT = 1
$env:PAGER = "less"
$env:OLDPATH = $env:PATH.Clone()
# Add ~/bin and python user-base scripts folder to PATH.
# `pipenv` is installed ther
# TODO: Use `pipx` to install `pipenv` in its own env.
$env:PATH = "C:/Users/Carl/bin;$env:PATH"
#$env:EDITOR = "codium"
#$env:GIT_PAGER = 'delta'
#$env:PATH = "C:/Users/Carl/AppData/Roaming/Python/Python311/Scripts;$env:PATH"
# ! Add nmap's `npcap` to PATH so wireshark can work
#$oldPath = $env:Path
#$env:Path = "$env:USERPROFILE/scoop/apps/nmap/current;$env:Path"

function Show-Welcome {
    param([switch]$verb)
    if ($verb) {
        write-host -fore Magenta "`$verb is $verb"
    }

    Write-Host -fore cyan "Welcome to the REWRITE of the Powershell `$profile"
    Write-Host -fore DarkCyan "`nNow I have to rewrite the entire profile and remember what alterations I did."

    return $true

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


Show-Welcome


new-alias Prepare-Pipenv C:\Users\Carl\Documents\virt_env_test\pipenv_test\preparepipenv.ps1 -Description @"
Adds location of ``pipenv`` to `$PATH
"@ -Option None -Scope Local

$Script:msyslocation = "C:\Users\Carl\scoop\apps\msys2\current"

New-Alias -Name msysshell -Value "$msyslocation\msys2_shell.cmd" -Description "msys2_shell.cmd alias" -Option AllScope

New-Alias chtsh C:\Users\Carl\Documents\BASICS\getChtsh.ps1 `
    -Description "Chtsh function"

Import-Module C:/Users/Carl/documents/BASICS/SearchTools/SearchTools.psd1

new-alias g git -Description "Super short git invokation ftw.  1/3 the length!"


sal pn pnpm
sal fe ForEach-Object
sal sel Select-Object

oh-my-posh init pwsh --config C:\Users\Carl\scoop\apps\oh-my-posh\current\themes\sonicboom_dark.omp.json | invoke-expression
