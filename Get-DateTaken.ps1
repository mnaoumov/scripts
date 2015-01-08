#requires -version 2.0

[CmdletBinding()]
param
(
)

$script:ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
function PSScriptRoot { $MyInvocation.ScriptName | Split-Path }

trap { throw $Error[0] }

# See spec http://www.awaresystems.be/imaging/tiff/tifftags/privateifd/exif.html
$ExifTagCode_DateTimeOriginal = 0x9003

function Get-DateTaken
{
    param
    (
        [string] $ImagePath
    )

    $str = Get-ExifProperty -ImagePath $ImagePath -ExifTagCode $ExifTagCode_DateTimeOriginal

    if ($str -eq $null)
    {
        return $null
    }

    $dateTime = [DateTime]::MinValue
    if ([DateTime]::TryParseExact($str, "yyyy:MM:dd HH:mm:ss", $null, [System.Globalization.DateTimeStyles]::None, [ref] $dateTime))
    {
        return $dateTime
    }

    return $null
}

function Get-ExifProperty
{
    param
    (
        [string] $ImagePath,
        [int] $ExifTagCode
    )

    $fullPath = Resolve-PathSafe $ImagePath

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
