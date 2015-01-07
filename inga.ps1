$tableCaption = "powerexp15JR"

$table = @"
       [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]
[1,] 0.0510 0.0810 0.1630 0.3200 0.5075 0.7155 0.8610
[2,] 0.0415 0.1010 0.2225 0.4225 0.5915 0.7580 0.8900
[3,] 0.0440 0.1055 0.2280 0.4285 0.5940 0.7615 0.8920
[4,] 0.0470 0.1100 0.2345 0.4265 0.5935 0.7590 0.8875
"@

$numbers = $table -split "`r`n" | % {
   @(,($_ -split "\s|\[.*\]" | ? { $_ }))
}

$rowCaptions = @("PowerF", "Power$\Lambda$", "PowerLR", "PowerNC")

$tex = "\begin{table*}
\caption{$tableCaption}
\label{K11}
\begin{center}
\begin{tabular}{|l|l|l|l|l|l|l|l|l|}
\hline
\multicolumn{1}{|c|}{$\sum\mu ^2$} & \multicolumn{1}{c|}{0.0} & \multicolumn{1}{c|}{0.4} & \multicolumn{1}{c|}{1.6} & \multicolumn{1}{c|}{3.6} & \multicolumn{1}{c|}{6.4} &
\multicolumn{1}{c|}{10} & \multicolumn{1}{c|}{14.4} \\
\hline"

$index = 0
foreach ($row in $numbers)
{
    $tex += "`n\multicolumn{1}{|c|}{$($rowCaptions[$index])}"
    foreach ($number in $row)
    {
        $tex += " & \multicolumn{1}{c|}{$number}"
    }
    $tex += "\\`n\hline"
    $index++
}

$tex += "`n\end{tabular}
\end{center}
\end{table*}"

$tex >> C:\tools\1.txt