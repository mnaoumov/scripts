cd C:\tools\ExifTool
$files = dir c:\_TODO\2014-03-04-videos  -filter *.mp4 -recurse

$files | % {
    write-host "Processing $_"
    #$dateStr = (($_.Directory.Name) -split "\.")[0]
    $dateStr = $_.Name.Substring(0, 19)
    #$date = [DateTime] $dateStr
    $date = [DateTime]::ParseExact($dateStr, "yyyy-MM-dd-HH-mm-ss", $null)

    $dateStrFormatted = $date.ToString("yyyy:MM:dd HH:mm:sszzz")

    .\exiftool.exe  $_.FullName "-FileModifyDate=$dateStrFormatted" "-FileCreateDate=$dateStrFormatted" "-CreateDate=$dateStrFormatted" "-ModifyDate=$dateStrFormatted" "-TrackCreateDate=$dateStrFormatted" "-TrackModifyDate=$dateStrFormatted" "-MediaCreateDate=$dateStrFormatted" "-MediaModifyDate=$dateStrFormatted"

    $_.CreationTime = $date
}