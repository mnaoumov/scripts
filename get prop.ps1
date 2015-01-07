function PSUsing
{
    param
    (
        [IDisposable] $disposable,
        [ScriptBlock] $scriptBlock
    )

    try
    {
        & $scriptBlock
    }
    finally
    {
        if ($disposable -ne $null)
        {
            $disposable.Dispose()
        }
    }
}

function aaa
{
    PSUsing ($fs = [System.IO.File]::OpenRead("d:\_AllPhotos\_TODO\Photo\jpg-new\NoDate\1401453008918.jpg")) `
    {
        PSUsing ($image = [System.Drawing.Image]::FromStream($fs, $false, $false)) `
        {
            foreach ($propItem in $image.PropertyItems)
            {
                $propItem.Id
                $valueBytes = $propItem.Value
                $value = [System.Text.Encoding]::ASCII.GetString($valueBytes)
                $value
                "---"
            }
        }
    }

}

aaa > c:\dev\1.txt