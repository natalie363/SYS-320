<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


        # - Checks if the given string is at least 6 characters
        # - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        # - If the given string does not satisfy conditions, returns false
        # - If the given string satisfy the conditions, returns true

function checkPassword($password) {
    #write-host "checkpassword was called"
    if ($password.length -lt 6) {
        #Write-Host 'password does not meet length requirements'
        return $false
        }
    elseif ($password -notmatch '.+[0-9].+'){
        #Write-Host 'password does not contain number'
        return $false
        }
     elseif ($password -notmatch '.+([a-z]|[A-Z]).+'){
         #Write-Host 'password does not contains letter'
         return $false
         }
      elseif ($password -notmatch '.+[^A-Za-z0-9].+'){
          #Write-Host 'password does not contains special character'
          return $false
          }
      else {
          #Write-Host 'this hypothetically worked??'
          return $true
          }
    }
