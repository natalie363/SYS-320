function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.10/Courses.html

$trElements = $page.ParsedHtml.body.getElementsByTagName("tr")

$fullTable = @()
for ($i=1; $i -lt $trElements.length; $i++){
    $tdElements = $trElements[$i].getElementsByTagName("td")

    $times = $tdElements[5].innerText.split("-")
    
    $FullTable += [PSCustomObject]@{"Class Code" = $tdElements[0].innerText; `
                                    "Title" = $tdElements[1].innerText; `
                                    "Days" = $tdElements[4].innerText; `
                                    "Time Start" = $times[0];`
                                    "Time End" = $times[1]; `
                                    "Instructor" = $tdElements[6].innerText; `
                                    "Location" = $tdElements[9].innerText; `
                                    }

}
return $fullTable
}

function daysTranslator($FullTable) {
for ($i=0; $i -lt $FullTable.length; $i++){
    $days = @()
    if ($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }
    if ($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
    if ($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }
    if ($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }
    if ($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }
    $FullTable[$i].Days = $days
}
return $FullTable
}


