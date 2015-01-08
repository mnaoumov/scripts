$ErrorActionPreference = "Stop"

gc C:\dev\newnames.txt | % {

$parts = $_ -split ";;;"

$filePath = $parts[0] -replace ".FullName"
$newName = $parts[1]
$newNameWithoutExtension = $newName -replace ".jpg"

$file = gi $filePath -ErrorAction SilentlyContinue

if ($file -eq $null)
{
    "Skip $filePath"
    return
}

if ($file.Name -like "$newNameWithoutExtension*")
{
    return
}

Rename-Item $filePath $newName -Verbose -ErrorAction Stop

}