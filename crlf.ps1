Get-ChildItem c:\dev\risc -recurse  | ForEach-Object { 
    if ($_.PSIsContainer)
    {
        return
    }
    
    $content = [IO.File]::ReadAllText($_.FullName)
    $fixed = $content -replace "([^`r])`n", "`$1`r`n"
    if ($content -ne $fixed)
    {
        write-host $_.FullName
        [IO.File]::WriteAllText($_.FullName, $fixed)
    }
}