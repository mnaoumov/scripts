#requires -version 2.0

[CmdletBinding()]
param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

trap { 

throw $Error[0] }

dir *.jpg -recurse | % `
{
    $name = $_.Name
    $dir = $_.Directory.FullName
    $date = $name | Select-String "^(?<Date>\d{4}-\d{2}-\d{2}).*" | % { $_.Matches } | % { $_.Groups["Date"].Value }

    if (-not $date)
    {
        return
    }

    if (-not (Test-Path "$dir\$date"))
    {
        md "$dir\$date"
    }
    mv "$dir\$name" "$dir\$date"
}