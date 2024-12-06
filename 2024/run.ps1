$day = Get-Date -Format "dd"
$esc = [char]27
$ErrorActionPreference = "Stop"
$intxt = "input"

$i = 0
if ($args[0] -eq "test") { $intxt = "test"; $i++ }
if ($args[0] -eq "golf") { $ver = "-golf"; $i++ }
if ($args[$i]) { $part = "{0:d1}" -f [int]$args[$i] }
if ($args[$i + 1]) { $day = "{0:d2}" -f [int]$args[$i + 1] }

if ($part) {
    $scriptName = "${day}-$part$ver.rb"
}
else {
    $scriptName = "${day}$ver.rb"
}

Write-Output "$scriptName : $((Get-Item $scriptName).Length) Bytes"
Get-Content $intxt | ruby $scriptName | Tee-Object -Variable cmdOutput
if (-not $?) { Exit }
Write-Output ""

$answer = $cmdOutput | Select-Object -Last 1
if ($answer -match "Part\s*(\d):\s*(\d+)" -and $matches) {
    $val = $matches[2]
    $part = $matches[1]

    $confirmation = Read-Host "$esc[32mSubmit $esc[1;37m$val$esc[22m to part $esc[1m${part}$esc[22m? [Y/N]"
    
    if ($confirmation -eq 'Y') {
        aoc s -d $day $part $val
    }
    if ($confirmation -eq 'N') {
        Write-Output "> aoc s $part $val"
    }
}
