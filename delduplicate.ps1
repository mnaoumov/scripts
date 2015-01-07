cd d:\_AllPhotos\_TODO\Photos

dir *_Dup* | % {
    $size = $_.Length
    $original = $_.FullName -replace "_Dup\d+"
    $originalSize = (gi $original).Length

    if ($size -eq $originalSize)
    {
        $_ | Remove-Item
    }

}