function Get-ProjectDirectory {
    <#
    .SYNOPSIS
    Get information about projects directory.s
    #>
    [cmdletbinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [ValidateSet("powershell", "python", "deno")]
        [string]$Language,

        [Parameter()]
        [Alias("a")]
        [switch]$All
    )

    $AllLanguages = @("powershell", "python", "deno")
    $projectsDirectory = "$env:USERPROFILE/Documents/projects"
    if (-not $Language) { return Get-Item $projectsDirectory }
    if ($All) {
        foreach ($lang in $AllLanguages) {
            return Get-ChildItem -Directory -Path "$projectsDirectory/$lang"
        }
    }
    return Get-ChildItem -Directory -Path "$projectsDirectory/$Language"
}
