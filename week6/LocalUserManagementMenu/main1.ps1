. (Join-Path $PSScriptRoot Users1.ps1)
. (Join-Path $PSScriptRoot Event-Logs1.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - View At-Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -Prompt "Please enter the password for the new user"

        
        if (checkUser $name){
            Write-Host "User $($name) already exists, returning to menu"
            continue
            }
        else{
            if (checkPassword $password){
                Write-Host "Password has met complexity requirements"
                $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
            }
            else {
                Write-Host "Password has not met complexity requirements, returning to menu"
                continue
        }}
        # Check the given username.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
        # Check the given password. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        createAUser $name $securePassword

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # Check the given username with the checkUser function.
        if (checkUser $name){
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
            }
        else{
            Write-Host "User $name does not exist, returning to main menu"
            continue
            }
        
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # Check the given username with the checkUser function.
        if (checkUser $name){
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
            }
        else{
            Write-Host "User $name does not exist, returning to main menu"
            continue
            }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # Check the given username with the checkUser function.
        if (checkUser $name){
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
            }
        else{
            Write-Host "User $name does not exist, returning to main menu"
            continue
            }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # Check the given username with the checkUser function.
        if (checkUser $name){
            $userLogins = getLogInAndOffs 90
            # Change the above line in a way that, the days 90 should be taken from the user
            }
        else {
            Write-Host "User $name does not exist, returning to main menu"
            continue
            }

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # Check the given username with the checkUser function.
        if (checkUser $name) {
            $userLogins = getFailedLogins 90
            # Change the above line in a way that, the days 90 should be taken from the user
            }
        else {
            Write-Host "User $name does not exist, returning to main menu"
            continue
            }
        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    #  "List at Risk Users" Lists all the users with more than 10 failed logins in the last <User Given> days.  
                   
    elseif($choice -eq 9) {
        # At Risk Users
        $logDays = Read-Host -Prompt "Enter the number of days from which to view failed logins"
        $allMissedLogs = getFailedLogins $logDays
        Write-Host ($allMissedLogs | Group-Object -Property user | Where-Object {$_.count -ge 10} | format-table -Property count, name | out-string)
        
    }
    # If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    else {
        Write-Host "Invalid selection. Returning to main menu."
        continue
    }
}




