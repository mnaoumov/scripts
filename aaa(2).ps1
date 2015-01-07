#requires -version 2.0

param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

function ThrowFunction($i)
{
    "ThrowFunction $i"
    $someNonExistingVariable
}

@(1, 2, 3) | ForEach-Object -Process { ThrowFunction $_ }