<#
.SYNOPSIS
Generate a test plan report

.DESCRIPTION
Specify the ID of the test plan to schedule a job to generate a test plan report

.OUTPUTS
Returns an object with the Job ID to check with further calls and the URL of the report for download

.NOTES
Make sure you have used Connect-Automai before you run this command
You need to run Get-JobStatus to see when its complete

.EXAMPLE
Get-LoaderReport -authHeader $token -automaiServer automai-01.ctxlab.local -automaiPort 8888 -testPlanID AL-4537 -testRunID 33 -reportType transaction
Schedules a report generation for test id AL-4537, run if 33 for a transaction report.
Returns an xml object with the success or failure, the schedule id and url for the report download when completed
#>

Function Get-LoaderReport {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage = "Authentication header object")]
        [ValidateNotNullOrEmpty()]
        $authHeader,
        [Parameter(Mandatory=$true, HelpMessage = "IP Address or hostname of your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiServer,
        [Parameter(Mandatory=$true, HelpMessage = "Port of your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiPort,
        [Parameter(Mandatory=$false, HelpMessage = "Use SSL communication for the connection")]
        [ValidateNotNullOrEmpty()]
        [switch]$UseSSL,
        [Parameter(Mandatory=$true, HelpMessage = "Test Plan ID")]
        $testPlanID,
        [Parameter(Mandatory=$false, HelpMessage = "Test Run ID")]
        $testRunID,
        [Parameter(Mandatory=$false, HelpMessage = "Report type - detailed, summary, transaction, raw")]
        [ValidateSet("detailed","summary","transaction","raw")]
        $reportType,   
        [Parameter(Mandatory=$false, HelpMessage = "Verbose output to see errors if there is a problem")]
        [Switch]$detailedOutput
    )

if ($authHeader) {
    #User logged in and can proceed
} else {
    Write-Host "Authentication header not set, please use Connect-Automai first."
    Exit
}

#Set wether the API call is HTTPS or not
if ($UseSSL) {
    $protocol = "https://"
} else {
    $protocol = "http://"
}

#Generate an API token and return it
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/loader/createreportjob/"

try {                
    
    $post_Body = @{
        tp_custom_id = $testPlanID
        tpr_id = $testRunID
        report_type = $reportType
    }

    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }    
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return [PSCustomObject]@{
    Job_ID = $response.root.aq_id
    URL = "$($protocol)$($automaiServer):$($automaiPort)/$($response.root.report_name)"
}

}