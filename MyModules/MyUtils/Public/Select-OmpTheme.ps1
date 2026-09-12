function Select-OmpTheme {
    <#
    .SYNOPSIS
    Selects an Oh-My-Posh theme using fzf.
    .DESCRIPTION
    Prompts the user to select a theme from the available ones using fzf.
    .LINK
    https://ohmyposh.dev/
    #>
    [CmdletBinding()]
    param()
    $theme = (Get-ChildItem $env:POSH_THEMES_PATH -Filter *.omp.json).BaseName -replace '\.omp$' | fzf
    oh-my-posh init powershell --config $theme | Invoke-Expression
}
