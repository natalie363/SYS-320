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



function powerLogs($timeframe){
# Gets the login/logout events from the past 14 days
$powerevents = Get-EventLog system -Source EventLog -After (Get-Date).AddDays(-"$timeframe")

#creates an array
$powereventstable = @()
for($i=0; $i -lt $powerevents.Count; $i++){
  # Event property value
  $event = ""
  if ($powerevents[$i].EventID -eq 6005) {$event="Startup"}
  if ($powerevents[$i].EventID -eq 6006) {$event="Shutoff"}
  if ($powerevents[$i].EventID -ne 6005 -and $powerevents[$i].EventID -ne 6006) {continue}

  # Add lines to empty array
  $powereventstable += [pscustomobject]@{"Time" = $powerevents[$i].TimeGenerated; `
                                       "Id" = $powerevents[$i].EventID; `
                                       "Event" = $event; `
                                       "User" = "System";
                                       }
  }
return $powereventstable
}
