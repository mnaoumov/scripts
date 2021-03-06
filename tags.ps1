$versionInfoChangeCommits = git log --all --format=%H "--" Risc.VTA.BackOffice/Risc.VTA.BackOffice.VersionInfo.cs

foreach ($commit in $versionInfoChangeCommits)
{
    $parentCommit = "$commit^"
    
    $versionInfoContent = git show "$parentCommit`:Risc.VTA.BackOffice/Risc.VTA.BackOffice.VersionInfo.cs"
    
    $version = $versionInfoContent | `
        Select-String -Pattern "AssemblyVersion\(`"(?<Version>.*)`"\)" | `
        ForEach-Object -Process { $_.Matches } | `
        ForEach-Object -Process { $_.Groups["Version"].Value }
        
    git tag $version $parentCommit
    if (-not $?)
    {
        Write-Warning -Message "Could not tag $version for commit $parentCommit"
        continue
    }
    #git push origin tag $version
}