<#
.SYNOPSIS
Connects to the Automai Server API to generate a token

.DESCRIPTION
Connects to the Automai REST endpoint for Director to grab a token for further API calls.

.OUTPUTS
API token as a string.

.NOTES
If there is an issue grabbing the API token the script will fai

.parameter automaiServer 
IP Address or hostname of your Automai Director
.parameter automaiPort
Port of your Automai Director
.parameter automaiUsername 
Username of the login to your Automai Director
.parameter automaiPassword
Password of the login to your Automai Director
.parameter UseSSL
Use SSL communication for the connection

.EXAMPLE
Connect-Automai -automaiServer AUTOMAI-01.lab.local -automaiPort 8888 -automaiUsername admin -automaiPassword automai

This will log in to the AUTOMAI-01.lab.local server on port 8888 using the specified username and password and return an api token
#>

Function Connect-Automai {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, HelpMessage = "IP Address or hostname of your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiServer,
        [Parameter(Mandatory=$true, HelpMessage = "Port of your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiPort,
        [Parameter(Mandatory=$true, HelpMessage = "Username of the login to your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiUsername,
        [Parameter(Mandatory=$true, HelpMessage = "Password of the login to your Automai Director")]
        [ValidateNotNullOrEmpty()]
        $automaiPassword,
        [Parameter(Mandatory=$false, HelpMessage = "Use SSL communication for the connection")]
        [ValidateNotNullOrEmpty()]
        [switch]$UseSSL,
        [Parameter(Mandatory=$false, HelpMessage = "Verbose output to see errors if there is a problem")]
        [Switch]$detailedOutput
    )

#Reset the token variables
$token = ""

#Set wether the API call is HTTPS or not
if ($UseSSL) {
    $protocol = "https://"
} else {
    $protocol = "http://"
}

#Generate an API token and return it
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/generatetoken"
$authBody = [Ordered] @{
    username = $automaiUsername
    password = $automaiPassword
}

try {                
    #Write-Host "Attempting to connect to $($protocol)$($automaiServer):$($automaiPort)/api/generatetoken/"
    $authResponse = Invoke-RestMethod -Method Post -Uri $resourceUri -Body $authBody
    $token = $authResponse.root.token

    #Configure auth header for further api calls
    $authHeader = [Ordered] @{
        'Content-Type' = 'application/x-www-form-urlencoded'
        Accept = '*/*'
        Authorization = "token $token"
    }

    Return $authHeader
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }   
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}
}