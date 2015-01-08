#requires -version 2.0

[CmdletBinding()]
param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

trap { throw $Error[0] }

dir *.jpg -recurse | % {
    $date = Get-DateTaken -ImagePath $_.FullName
    if ($date -eq $null)
    {
        return
    }
    write-host $_.FullName
    $newName = ("{0:yyyy-MM-dd_HH-mm-ss}.jpg" -f $date)
    $dir = $_.Directory.FullName

    if ($_.Name -eq $newName)
    {
        return;
    }

    $newNameWithoutExtension = $newName -replace ".jpg"

    if ($_.Name -match "$($newNameWithoutExtension)_\d+.jpg")
    {
        return;
    }

    $nextNewName = "$($newNameWithoutExtension)_1.jpg"

    if ((Test-Path "$dir\$newName"))
    {
        try{
        Move-Item -LiteralPath "$dir\$newName" -Destination "$dir\$nextNewName"
        }
        catch
        {
          throw
        }

    }

    if ((Test-Path "$dir\$nextNewName"))
    {
        $counter = 2
        do
        {
            $newName = "$($newNameWithoutExtension)_$counter.jpg"
            $counter++
        }
        while (Test-Path "$dir\$newName")
    }

    try{
    Move-Item -LiteralPath $_.FullName -Destination "$dir\$newName"
    }
    catch
    {
    throw
    }
}