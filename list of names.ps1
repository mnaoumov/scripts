#requires -version 2.0

[CmdletBinding()]
param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

trap { throw $Error[0] }

dir d:\_AllPhotos -File -Recurse -Include *.jpg | % {
$date = Get-DateTaken $_.FullName

if ($date)
{
    $newName = "{0:yyyy-MM-dd_HH-mm-ss}.jpg" -f $date
    "$_.FullName;;;$newName" >> c:\dev\newnames.txt
}

}