# ScoopCompletions.psm1

# Default Scoop home
$scoopHome = "$env:USERPROFILE\scoop"

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

    Get-ChildItem -Path $appsRoot -Filter "_*.ps1" -Recurse -Depth 5  -ea silentlycontinue
}

function Enable-ScoopCompletions {
    <#
    .SYNOPSIS
    Dot-source each completion script found by Get-ScoopCompletions.
    .DESCRIPTION
    Loads Scoop completion scripts into the current session.
    .PARAMETER ScoopHome
    The path to the Scoop home directory. Default is ~\scoop
    .EXAMPLE
    Enable-ScoopCompletions -ScoopHome "C:\Users\username\scoop"
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ScoopHome = "$env:USERPROFILE\scoop"
    )

    $scripts = Get-ScoopCompletions -ScoopHome $ScoopHome

    if (-not $scripts) {
        Write-Verbose "No Scoop completion scripts found."
        return
    }

    foreach ($script in $scripts) {
        . $script.FullName
    }

    Write-Verbose "Scoop completions loaded."
}

Export-ModuleMember -Function Get-ScoopCompletions, Enable-ScoopCompletions
