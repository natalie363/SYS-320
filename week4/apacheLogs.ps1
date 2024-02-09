function accessedPages( $page, $code, $browserName ) {
$accessed = Get-Content C:\xampp\apache\logs\access.log | select-string -Pattern ".+$page.+$code.+$browserName.+"


$unorganizedIP = ForEach-Object {[regex]::Matches($accessed, "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")}

$ips = @()
for ($i=0; $i -lt $unorganizedIP.Count; $i++){
  $ips += [pscustomobject]@{ "IP" = $unorganizedIP[$i]; }
}

$ipFrequency = $ips | Where-Object { $_.IP -ilike "10.*" }
$ipFrequency | group-object IP | Select-Object Count, Name

} 