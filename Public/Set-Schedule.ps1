<#
.SYNOPSIS
Sets a schedule active or inactive

.DESCRIPTION
Sets a schedule as inactive or active to stop or start automated schedules

.OUTPUTS
Returns TRUE on success

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Set-Schedule -authHeader $token -automaiServer automai-01.ctxlab.local -automaiPort 8888 -detailedOutput -schedule 'new1' -flag inactive
Sets the schedule "new1" as inactive, Returns True
#>

Function Set-Schedule {
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
        [Parameter(Mandatory=$true, HelpMessage = "The name of the schedule to change")]
        $schedule,
        [Parameter(Mandatory=$false, HelpMessage = "active or inactive to change the schedule status")]
        [ValidateSet("active","inactive")]
        $flag,        
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/schedule/"

try {                
    
    $post_Body = @{
        schedule_name = $schedule
        flag = $flag
    }

    #Write-Host "Attempting to connect to $resourceUri"
    #Write-Host $post_Body
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }    
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response.root.success
}