function loginLogs($timeframe){
# Gets the login/logout events from the past 14 days
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-"$timeframe")

#creates an array
$loginoutstable = @()
for($i=0; $i -lt $loginouts.Count; $i++){
  # Event property value
  $event = ""
  if ($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
  if ($loginouts[$i].InstanceId -eq 7002) {$event="Logout"}

  # user property value
  $user = $loginouts[$i].ReplacementStrings[1]
  $sid = New-Object System.Security.Principal.SecurityIdentifier("$user")
  $translatedName = $sid.Translate([System.Security.Principal.NTAccount])

  # Add lines to empty array
  $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                       "Event" = $event; `
                                       "User" = $translatedName;
                                       }
  }
return $loginoutstable
}

loginLogs(14)