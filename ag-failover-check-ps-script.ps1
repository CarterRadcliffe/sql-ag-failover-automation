$outputPath = '<filepath for output file>'
$datetime   = Get-Date -f 'yyyyMMddHHmmss'
$filename   = "FailoverTranscript-${datetime}.txt"
$Transcript = Join-Path -Path $outputPath -ChildPath $filename
Start-Transcript $Transcript

Write-Output "`n"
Write-Output 'Beginning : AG Failover Checks'
Write-Output "`n"

# AG
# 
# ideal primary - xxxxxxxxxxxxx\xxxxxx
try {   
    $ag_listener  = ''
    $ag_replicas  = Get-DbaAgReplica -SqlInstance $ag_listener
    $ag_agName    = $ag_replicas | Select-Object -expandProperty AvailabilityGroup
    $ag_curPrim   = $ag_replicas | Where-Object Role -eq Primary | Select-Object -ExpandProperty name
    $ag_primary   = 'xxxxxx\xxxxxx'
    $ag_secondary = 'xxxxxx\xxxxxx'

    # if curPrimary is a secondary, failover
    if ($ag_curPrim -like $ag_secondary){
        Write-Output "Invoking DbaAgFailover for :'$($ag_listener )' -"(get-date)
        Invoke-DbaAgFailover -SqlInstance $ag_primary -AvailabilityGroup $ag_agName -Confirm:$false
        Write-Output "Completed DbaAgFailover for :'$($ag_listener )' -"(get-date)
        }
    else
        {
            Write-Output "No Failover Needed for :'$($ag_listener )' -"(get-date)
        }
    }
catch {
        $msg = $_.Exception.Message
        Write-Error "Error while attempting failover of availability groups'$($ag_agName): $msg' -"(get-date)
    }

Write-Output "`n"
Write-Output 'Completed : AG Failover Checks'
Write-Output "`n"

Stop-Transcript