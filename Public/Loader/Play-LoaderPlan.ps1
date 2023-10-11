<#
.SYNOPSIS
Schedules and plays a test plan

.DESCRIPTION
Specify the ID of the test plan to start the test plan

.OUTPUTS
Returns the ID of the scheduled test

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Play-TestPlan

#>

Function Play-LoaderPlan {
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
        [Parameter(Mandatory=$true, HelpMessage = "Number of users to run")]
        $testPlanUsers,
        [Parameter(Mandatory=$false, HelpMessage = "Enforce the steady state time or not")]
        [ValidateSet("yes","no")]
        $testPlanSteadyState,
        [Parameter(Mandatory=$false, HelpMessage = "Steady State time for the test plan")]
        $testPlanSteadyStateTime,
        [Parameter(Mandatory=$false, HelpMessage = "Test plan iterations, number of times to run the plan")]
        $testPlanIterations,
        [Parameter(Mandatory=$false, HelpMessage = "Notes for the test")]
        $testPlanNotes,
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/loader/createandplaytpr/"

try {                
    
    $post_Body = @{
        tp_custom_id = $testPlanID
        tp_rusers = $testPlanUsers
        tp_enforce_steady_state_time = $testPlanSteadyState
        tp_steady_state_time = $testPlanSteadyStateTime
        tp_iterations = $testPlanIterations
        tp_notes = $testPlanNotes
    }

    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }    
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response

}