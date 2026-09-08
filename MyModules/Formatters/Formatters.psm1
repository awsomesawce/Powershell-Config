filter Format-ScoopInfo {
   <#
   .SYNOPSIS
   Filter output from `scoop info`.
   .DESCRIPTION
   Filter output of `scoop info` into a markdown list.
   .EXAMPLE
   scoop info git | Format-ScoopInfo
   #>
   "* [$($_.Name)]($($_.Website)): $($_.Description)"
}

Export-ModuleMember -Functions "Format-ScoopInfo"
