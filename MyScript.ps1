#requires -version 2.0

$script:ErrorActionPreference = "Stop"

$someComplexCondition = $false

if ($someComplexCondition)
{
    Write-Error -Message "Some complex condition"
}
else
{
    Write-Error -Message "Other complex condition"
}
