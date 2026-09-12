# MyUtils.psm1
# Import public functions programmatically
$Public = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1"
foreach ($file in $Public) { . $file.FullName }
Export-ModuleMember -Function $Public.BaseName
