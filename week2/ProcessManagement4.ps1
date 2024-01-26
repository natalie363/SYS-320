$web_browser = Get-Process | Where-Object { $_.Name -ilike "chrome" }
if ($web_browser -eq $null) { 
    Start-Process -FilePath chrome.exe 'https://champlain.edu'
}
else {
    Stop-Process -Name chrome -Force
}
