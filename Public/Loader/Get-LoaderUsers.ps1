<#
.SYNOPSIS
Checks connected rLoader Users

.DESCRIPTION
Returns the number of rLoader users that are currently connected

.OUTPUTS
Number of rLoader users in XML Object

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Get-LoaderUsers -authHeader $token -automaiServer AUTOMAI-01.ctxlab.local -automaiPort 8888
This command will get a list of all rLoader users that are currently connected - returns the number of rLoaders connected

#>

Function Get-LoaderUsers {
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/loader/getavailableusers/"

try {                
    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Get -Uri $resourceUri -Headers $authHeader
    
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }   
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response.root.count

}