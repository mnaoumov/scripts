cd d:\_AllPhotos\_TODO\Photo\gif 

(dir) | % {
    $date = $_.LastWriteTime
    $newName = ("{0:yyyy-MM-dd_HH-mm-ss}.gif" -f $date)

    if ($_.Name -eq $newName)
    {
        return;
    }

    if ($_.Name -like "*_Dup*.gif")
    {
        return;
    }

    if (Test-Path $newName)
    {
        $counter = 0
        do
        {
            $newName = ".\{0:yyyy-MM-dd_HH-mm-ss}_Dup{1}.gif" -f $date, $counter
            $counter++
        }
        while (Test-Path $newName)
    }

    Rename-Item $_.FullName -NewName $newName
}