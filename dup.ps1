function Get-ExifProperty
{
    param
    (
        [string] $ImagePath,
        [int] $ExifTagCode
    )

    $fullPath = Resolve-PathSafe $ImagePath

    write-host $fullPath
    PSUsing ($fs = [System.IO.File]::OpenRead($fullPath)) `
    {
        PSUsing ($image = [System.Drawing.Image]::FromStream($fs, $false, $false)) `
        {
            if (-not $image.PropertyIdList.Contains($ExifTagCode))
            {
                return $null
            }

            $propertyItem = $image.GetPropertyItem($ExifTagCode)
            $valueBytes = $propertyItem.Value
            $value = [System.Text.Encoding]::ASCII.GetString($valueBytes) -replace "`0$"
            return $value
        }
    }
}

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

function Resolve-PathSafe
{
    param
    (
        [string] $Path
    )
     
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
}
<#
    PSUsing ($fs = [System.IO.File]::OpenRead("d:\_AllPhotos\_TODO\Photo\jpg-new\Dup\2013-11-28_11-55-37_Dup0.jpg")) `
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
#>


dir | % {

$soft = Get-ExifProperty -ImagePath $_.FullName -ExifTagCode 0x0131

if ($soft -eq $null)
{
return
}

if (-not (Test-Path $soft))
{
md $soft
}

mv $_.FullName $soft


 }
