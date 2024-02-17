. (Join-Path $PSScriptRoot webscraping.ps1)

$FullTable = daysTranslator(gatherClasses)


# Deliverable 1
$FullTable | Select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
Where { $_."Instructor" -ilike "Furkan Paligu" }

# Deliverable 2
$FullTable | Where { ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | `
    Sort-Object "Time Start" | `
    Select "Time Start", "Time End", "Class Code"

# Deliverable 3
$ITSInstructors = $FullTable | Where { ($_."Class Code" -ilike "SYS*") -or `
                                       ($_."Class Code" -ilike "NET*") -or `
                                       ($_."Class Code" -ilike "SEC*") -or `
                                       ($_."Class Code" -ilike "FOR*") -or `
                                       ($_."Class Code" -ilike "CSI*") -or `
                                       ($_."Class Code" -ilike "DAT*") } `
                             | Select "Instructor" `
                             | Sort-Object "Instructor" -Unique

# Deliverable 4
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select Count, Name | Sort Count -Descending
           
                             
