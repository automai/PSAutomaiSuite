<#
.SYNOPSIS
Schedules and plays a worker or tester flow

.DESCRIPTION
Specify the ID of the flow to start the flow

.OUTPUTS
Returns success or failure

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Play-WorkerTesterFlow -authHeader $token -automaiServer automai-01.ctxlab.local -automaiPort 8888 -flowID AW-7307
Will play worker/tester plan AW-7307 and return success or otherwise

#>

Function Play-WorkerTesterFlow {
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
        $flowID,               
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/worker/createandplayfr/"

try {                
    
    $post_Body = @{        
        f_custom_id = $flowID
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