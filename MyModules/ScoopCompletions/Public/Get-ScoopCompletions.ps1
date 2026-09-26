function Get-ScoopCompletions {
    <#
    .SYNOPSIS
    Gather completion scripts from scoop-installed applications.
    .DESCRIPTION
    Searches for Scoop completion scripts (_*.ps1) inside the apps directory.
    .PARAMETER ScoopHome
    The path to the Scoop home directory. Default is ~\scoop
    .EXAMPLE
    Get-ScoopCompletions -ScoopHome "C:\Users\username\scoop"
    .EXAMPLE
    Get-ScoopCompletions
    .NOTES
    Toying with whether or not to include the Where block for filtering out symlinked directories.
    Scoop installs apps into a "current" directory that is symlinked to the latest version.
        `Where-Object { $null -eq $_.Directory.LinkType }` will filter out symlinked directories.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ScoopHome = "$env:USERPROFILE\scoop"
    )

    if (-not (Test-Path $ScoopHome)) {
        Write-Warning "Scoop home not found: $ScoopHome"
        return
    }

    $appsRoot = Join-Path $ScoopHome "apps"

    return Get-ChildItem -Path $appsRoot -Directory -Filter "current" -Depth 1 -ea SilentlyContinue |
        ForEach-Object {
            Get-ChildItem -Path $_.FullName -Filter "_*.ps1" -Depth 4 -ea SilentlyContinue
        }
}
