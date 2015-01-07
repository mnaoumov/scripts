#requires -version 2.0

param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

$a = $Args -join " "
$b = $a -split "\^\^\^"
<#
echo `
@"
& "C:\Program Files\Devart\Code Compare\CodeMerge.exe -MF=`"$($b[0])`" -TF=`"$($b[1])`" -BF=`"$($b[2])`" -RF=`"$($b[3])`""
"@

exit 1
#>

$p = Start-Process -FilePath "C:\Program Files\Devart\Code Compare\CodeMerge.exe" -ArgumentList @("-MF=`"$($b[0])`"", "-TF=`"$($b[1])`"", "-BF=`"$($b[2])`"", "-RF=`"$($b[3])`"") -Wait -PassThru

exit $($p.get_ExitCode())