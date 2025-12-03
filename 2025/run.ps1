$day = Get-Date -Format "dd"
$year = Split-Path . -Leaf
$esc = [char]27
$ErrorActionPreference = "Stop"
$intxt = "input"

$i = 0
if ($args[0] -eq "test") { $intxt = "test"; $i++ }
if ($args[0] -eq "golf") { $ver = "-golf"; $i++ }
if ($args[$i]) { $part = "{0:d1}" -f [int]$args[$i] }
if ($args[$i + 1]) { $day = "{0:d2}" -f [int]$args[$i + 1] }

if ($part) { $scriptName = "${day}-$part$ver.zig" }
else { $scriptName = "${day}$ver.zig" }

if (Test-Path "puzzle.md") {
    $i = "" -match ""
    $i = Get-Content puzzle.md | ? { $_ -match "(\d+)%2Fday%2F(\d+)" }
    $yearPuz, $dayPuz = $matches[1..2]
    $dayPuz = ("0$dayPuz")[-2..-1] -join ''
    if ($dayPuz -ne $day) {
        Write-Output "Downloading $year/$day (have $yearPuz/$dayPuz)"
        aoc d -o -y $year -d $day
    }
}
else {
    Write-Output "Downloading $year/$day"
    aoc d -o -y $year -d $day
}

Write-Output "$scriptName : $((Get-Item $scriptName).Length) Bytes"
Get-Content $intxt | zig run $scriptName | Tee-Object -Variable cmdOutput
if (-not $?) { Exit }
Write-Output ""

$prev = @(Get-Content puzzle.md | ? { $_ -match "Your puzzle answer was" } | % { $_.Split('`')[1] })
$cmdOutput | % {
    if ($_ -notmatch "Part\s*(\d):\s*(\S+)" -or $_ -match "false$") { return }

    $val = $matches[2]
    $part = $matches[1]
    if ($part -le $prev.Length) {
        if ($val -ne $prev[$part - 1]) {
            $text = "That's $esc[31mnot$esc[37m the right answer for $esc[1mpart $part$esc[22m! The right answer was"
            Write-Output "$text $esc[1m$($prev[$part-1])$esc[22m"
        }
        return
    }

    $confirmation = Read-Host "$esc[32mSubmit $esc[37m$val$esc[22m to part $esc[1m${part}$esc[22m? [Y/N]"
    Write-Output "> aoc s -y $year -d $day $part $val"
    
    if ($confirmation -eq 'Y') {
        $response = aoc s -y $year -d $day $part $val
        Write-Output $response
        if ($response -match "That's the right answer!") { aoc d -P -o -y $year -d $day }
    }
}