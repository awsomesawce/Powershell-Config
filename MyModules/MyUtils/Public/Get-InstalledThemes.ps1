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
