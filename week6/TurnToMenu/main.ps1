. (Join-Path $PSScriptRoot functions.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs `n"
$Prompt += "2 - Display Last 10 Failed Logins `n"
$Prompt += "3 - Display At-Risk Users `n"
$Prompt += "4 - Launch or close champlain.edu in Chrome `n"
$Prompt += "5 - Exit `n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }
    elseif($choice -eq 1){
        # Display last 10 apache logs
        parsingLogs
        
    }
    elseif($choice -eq 2){
        #Display last 10 failed log-ins
        fails
    }
    elseif($choice -eq 3){
        # at risk users
        $logDays = Read-Host "Enter the number of days from which to view failed logins"
        atRiskUsers $logDays
    }
    elseif($choice -eq 4){
       #access champlain 
       processManager
    }
    else{
        Write-Host "Invalid selection. Returning to main menu.`n"
        continue
    }
}

