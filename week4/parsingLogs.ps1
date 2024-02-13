function parsingLogs() {
$unformattedLogs = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $unformattedLogs.Length; $i++) {
  
  $words = $unformattedLogs[$i].Split(" ");

  $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                      "Time" = $words[3]; `
                                      "Method" = $words[5]; `
                                      "Page" = $words[6]; `
                                      "Protocol" = $words[7]; `
                                      "Response" = $words[8]; `
                                      "Referrer" = $words[10]; `
                                      "Client" = $words[11 .. ($words.Count)] }

  }

return $tableRecords | Where-Object {$_.IP -ilike "10.*" } | Format-Table -AutoSize -Wrap

}
