#requires -version 2.0

[CmdletBinding()]
param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

$map = gc "$(PSScriptRoot)\RISC\.git\svn\authors.txt" | `
    Select-String "^(?<Alias>[\w._]+) = (?<Name>[\w _]+) \<(?<Email>.*)\>" | `
    % { $_.Matches } | `
    % { New-Object PSObject -Property @{ Alias = $_.Groups["Alias"].Value; Name = $_.Groups["Name"].Value; Email = $_.Groups["Email"].Value } }


$map | % {
@"
        "$($_.Alias)") n="$($_.Name)" ; m="$($_.Email)" ;;
"@
}