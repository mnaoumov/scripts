@'
#!/bin/sh
n=$GIT_AUTHOR_NAME
m=$GIT_AUTHOR_EMAIL

case ${GIT_AUTHOR_NAME} in
'@ | Out-File -FilePath MyScript.sh -Encoding Ascii

Get-Content -Path ".git\svn\authors.txt" | `
    Select-String -Pattern "^(?<Alias>[\w._]+) = (?<Name>[\w _]+) \<(?<Email>.*)\>" | `
    ForEach-Object -Process { $_.Matches } | `
    ForEach-Object -Process `
        {
            New-Object -TypeName PSObject -Property `
                @{
                    Alias = $_.Groups["Alias"].Value;
                    Name = $_.Groups["Name"].Value;
                    Email = $_.Groups["Email"].Value;
                }
        } |
    ForEach-Object -Process `
        {
@"
        "$($_.Alias)") n="$($_.Name)" ; m="$($_.Email)" ;;
"@
        } | Add-Content -Path MyScript.sh -Encoding Ascii

@'
esac

export GIT_AUTHOR_NAME="$n"
export GIT_AUTHOR_EMAIL="$m"
export GIT_COMMITTER_NAME="$n"
export GIT_COMMITTER_EMAIL="$m"

'@ | Add-Content -Path MyScript.sh -Encoding Ascii