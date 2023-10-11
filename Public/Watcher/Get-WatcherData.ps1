<#
.SYNOPSIS
Gets Watcher report data

.DESCRIPTION
Returns the number of rLoader users that are currently connected

.OUTPUTS
Returns report information

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Get-WatcherData

This command will get a list of all available reports
#>

Function Get-WatcherData {
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
        [Parameter(Mandatory=$true, HelpMessage = "Timestamp value - MMM/dd/yyyy - example JUN/29/2023")]
        $timestamp,
        [Parameter(Mandatory=$false, HelpMessage = "Last report id number")]
        $last_report_id,
        [Parameter(Mandatory=$false, HelpMessage = "Location name")]
        $location_name,
        [Parameter(Mandatory=$false, HelpMessage = "Watcher id's seperated by a comma")]
        $watcher_ids,
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/watcher/getwatcherdata/"

try {                
    
    $post_Body = @{
        timestamp = Get-Date $([Datetime]::ParseExact($timestamp, 'MMM/dd/yyyy-HHmm', $null)) -UFormat %s
        last_report_id = $last_report_id
        location_name = $location_name
        watcher_ids = $watcher_ids
    }

    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
        Write-Host $timestamp
    }    
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response.report

}