function Enable-ScoopCompletions {
    <#
    .SYNOPSIS
    Dot-source each completion script found by Get-ScoopCompletions.
    .DESCRIPTION
    Loads Scoop completion scripts into the current session.
    .PARAMETER ScoopHome
    The path to the Scoop home directory. Default is ~\scoop
    .EXAMPLE
    Enable-ScoopCompletions
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
        Write-Verbose "Sourcing $($script.FullName)"
        . $script.FullName
    }

    Write-Verbose "Completions enabled."
}
