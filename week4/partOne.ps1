# this is code from the first part of the assignment, and is not a part of Deliverable 9
$notFound = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

$unorganizedIP = ForEach-Object {[regex]::Matches($notFound, "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")}

$ips = @()
for ($i=0; $i -lt $unorganizedIP.Count; $i++){
  $ips += [pscustomobject]@{ "IP" = $unorganizedIP[$i]; }
}
#$ips | Where-Object { $_.IP -ilike "10.*" }

$ipFrequency = $ips | Where-Object { $_.IP -ilike "10.*" }
$ipFrequency | group-object IP | Select-Object Count, Name

