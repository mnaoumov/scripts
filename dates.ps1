dir *.jpg | % `
{
    $name = $_.Name
    $date = ($name -split "_")[0]
    if (-not (Test-Path $date))
    {
        md $date
    }
    mv $name $date
}