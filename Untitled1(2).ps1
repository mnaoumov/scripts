function Invoke-SqlCmdEx
{
    param
    (
        [string] $ServerInstance,
        [string] $Database,
        [string] $User,
        [string] $Password,
        [string] $InputFile
    )

    if (-not (Get-Command -Name sqlcmd.exe))
    {
        throw "sqlcmd.exe not found"
    }
    
    $sqlCmdArguments = `
        @(
            "-S",
            $ServerInstance,
            "-d",
            $Database,
            "-b",
            "-r",
            1
        )
        
        if ($User)
        {
            $sqlCmdArguments += `
                @(
                    "-U",
                    $User,
                    "-P",
                    $Password
                )
        }
        else
        {
            $sqlCmdArguments += "-E"
        }


    $scriptLines = @(Get-Content -Path $InputFile) + "GO"
    $currentBatch = ""
    $currentBatchSize = 0
    $offset = 0

    foreach ($line in $scriptLines)
    {
        if ($line -match "\S*GO\S*")
        {
            if ($currentBatch -notmatch "^\s*$")
            {
                $result = sqlcmd.exe -Q $currentBatch $sqlCmdArguments 2>&1
                $result | % { "$_" }
                
                if ($LASTEXITCODE -ne 0)
                {
                    throw "offset $offset --- sqlcmd failed for script $InputFile with error code $LASTEXITCODE"
                }

            }
                        
            $offset += $currentBatchSize + 1
            $currentBatchSize = 0
            $currentBatch = ""
        }
        else
        {
            $currentBatch += "`r`n$line"
            $currentBatchSize++
        }
    }
}

Invoke-SqlCmdEx -ServerInstance . -Database VTA-Production -InputFile C:\1.sql