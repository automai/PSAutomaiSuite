<#
.SYNOPSIS
Get the current status of a job

.DESCRIPTION
Specify the ID of the job obtained by Get-LoaderReport to get the current status of the job

.OUTPUTS
Returns the status of the job

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Get-JobStatus -authHeader $token -automaiServer automai-01.ctxlab.local -automaiPort 8888 -jobID AR014453
Returns Job Status

This command will schedule and run a test
#>

Function Get-JobStatus {
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
        [Parameter(Mandatory=$false, HelpMessage = "Job ID")]
        $jobID,        
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/loader/queueitemstatus/"

try {                
    
    $post_Body = @{
        aq_id = $jobID
    }

    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }    
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response.root.status

}