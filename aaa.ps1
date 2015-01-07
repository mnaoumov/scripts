$someComplexCondition = $false

if ($someComplexCondition)
{
    Write-Error -Message "Some complex condition" -ErrorAction Stop
}
else
{
    Write-Error -Message "Other complex condition" -ErrorAction Stop
}
