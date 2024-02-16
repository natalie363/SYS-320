. (Join-Path $PSScriptRoot webscraping.ps1)

$FullTable = daysTranslator(gatherClasses)

<#$FullTable | Select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
Where { $_."Instructor" -ilike "Furkan Paligu" }#>

<#$FullTable | Where { ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | `
    Sort-Object "Time Start" | `
    Select "Time Start", "Time End", "Class Code"#>

$ITSInstructors = $FullTable | Where { ($_."Class Code" -ilike "SYS*") -or `
                                       ($_."Class Code" -ilike "NET*") -or `
                                       ($_."Class Code" -ilike "SEC*") -or `
                                       ($_."Class Code" -ilike "FOR*") -or `
                                       ($_."Class Code" -ilike "CSI*") -or `
                                       ($_."Class Code" -ilike "DAT*") } `
                             | Select "Instructor" `
                             | Sort-Object "Instructor" -Unique

$FullTable | for { $_.Instructor -in $ITSInstructors.Instructor } `
           
                             
