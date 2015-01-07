dir c:\_TODO\1   -filter *.mp4 | % {
    if ($_.Name -notmatch "(?<Year>\d{4})-(?<Month>\d{2})-(?<Day>\d{2})-(?<Hour>\d{2})-(?<Minute>\d{2})-(?<Second>\d{2})\.mp4")
    {
        throw "cannot parse $_"
    }

    $date = [DateTime] "$($Matches.Year)-$($Matches.Month)-$($Matches.Day) $($Matches.Hour):$($Matches.Minute):$($Matches.Second)"

    $dateStrFormatted = $date.ToString("yyyy:MM:dd HH:mm:sszzz")

    c:\tools\exiftool\exiftool.exe  $_.FullName "-FileModifyDate=$dateStrFormatted" "-FileCreateDate=$dateStrFormatted" "-CreateDate=$dateStrFormatted" "-ModifyDate=$dateStrFormatted" "-TrackCreateDate=$dateStrFormatted" "-TrackModifyDate=$dateStrFormatted" "-MediaCreateDate=$dateStrFormatted" "-MediaModifyDate=$dateStrFormatted"

    $_.CreationTime = $date
}