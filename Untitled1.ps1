function aaa
{
    begin
    {
        $tempLastResult = @()
        $count = 0;
    }
    process
    {
        $tempLastResult += @(,$_)
        $count++
        $_ | Microsoft.PowerShell.Core\Out-Default
    }
    end
    {
        if ($count -eq 1)
        {
            $Global:LastResult = $tempLastResult[0]
        }
        else
        {
            $Global:LastResult = $tempLastResult
        }
    }
}

1..10 | % { sleep -Milliseconds 300; $_ } | aaa

