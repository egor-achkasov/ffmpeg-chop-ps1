if ($args.Count -lt 3 -or ($args.Count - 1) % 2 -ne 0) {
    Write-Error "Usage: script.ps1 <input> <start1> <end1> [<start2> <end2> ...]"
    exit 1
}

$input = $args[0]
$times = $args[1..($args.Count - 1)]

if ($times.Count % 2 -ne 0) {
    Write-Error "Number of time points must be even."
    exit 1
}

$baseName = [System.IO.Path]::GetFileNameWithoutExtension($input)
$ext = [System.IO.Path]::GetExtension($input)

for ($i = 0; $i -lt $times.Count; $i += 2) {
    $start = $times[$i]
    $end = $times[$i + 1]
    $startTime = [TimeSpan]::Parse($start)
    $endTime = [TimeSpan]::Parse($end)
    $duration = $endTime - $startTime
    $index = [int]($i / 2) + 1
    $output = "$baseName-chop$index$ext"
    $cmd = "ffmpeg -ss $start -i `"$input`" -t $($duration.ToString()) -avoid_negative_ts make_zero -c copy -copyinkf -hide_banner -loglevel error -y `"$output`""
    Write-Output $cmd
    Invoke-Expression $cmd
}
