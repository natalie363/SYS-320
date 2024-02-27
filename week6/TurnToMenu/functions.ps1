

function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
}

function atRiskUsers($logDays) {
        $allMissedLogs = getFailedLogins $logDays
        Write-Host ($allMissedLogs | Group-Object -Property user | Where-Object {$_.count -ge 10} | format-table -Property count, name | out-string)

}
#atRiskUsers 4

# apachelogs1 from Parsing apache logs (last 10 logs)
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
return $tableRecords | Where-Object {$_.IP -ilike "10.*" } | select -first 10 | Format-Table -AutoSize -Wrap

}

# last 10 failed logins from all users (getfailed logins local user management menu)

function fails {
        $allMissedLogs = getFailedLogins 10
        Write-Host ($allMissedLogs | format-table | out-string)

}

# start chrome and go to champlain (process management 1)

function processManager {
    $web_browser = Get-Process | Where-Object { $_.Name -ilike "chrome" }
    if ($web_browser -eq $null) { 
        Write-Host "Opening Chrome"
        Start-Process -FilePath chrome.exe 'https://champlain.edu'
    }
    else {
        Write-Host "Closing Chrome"
        Stop-Process -Name chrome -Force
    }
}