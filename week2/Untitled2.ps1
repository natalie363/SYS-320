$files=Get-ChildItem C:\outfolder *.csv -Recurse
$files | Rename-Item -NewName {$_.name -Replace '.csv','.log' }
Get-ChildItem C:\outfolder -Recurse