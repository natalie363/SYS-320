. (Join-Path $PSScriptRoot functionsAndLogs.ps1)

# Get Login and Logoffs from the last 15 days
$loginoutsTable = loginlogs(15)
$loginoutsTable

# Get Shutdowns and startups from the past 25 days
$powertable = powerLogs(25)
$powertable