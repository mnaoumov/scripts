cd d:\_AllPhotos\_TODO\Photos 
dir *.jpg | % {
    $date = Get-DateTaken -ImagePath $_.FullName
    if ($date -eq $null)
    {
        Move-Item -LiteralPath $_.FullName -Destination ".\NoDate"
        return;
    }
    
    $newName = ".\{0:yyyy-MM-dd_HH-mm-ss}.jpg" -f $date

    if (".\$($_.Name)" -eq $newName)
    {
        return;
    }

    if ($_.Name -like "*_Dup*.jpg")
    {
        return;
    }

    if (Test-Path $newName)
    {
        $counter = 0
        do
        {
            $newName = ".\{0:yyyy-MM-dd_HH-mm-ss}_Dup{1}.jpg" -f $date, $counter
            $counter++
        }
        while (Test-Path $newName)
    }

    Move-Item -LiteralPath $_.FullName -Destination $newName
}