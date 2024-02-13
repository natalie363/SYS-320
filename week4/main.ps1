. (Join-Path $PSScriptRoot apacheLogs.ps1)
. (Join-Path $PSScriptRoot parsingLogs.ps1)

accessedPages '/index.html' '200' 'Mozilla'
parsingLogs