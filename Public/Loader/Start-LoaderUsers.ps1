<#
.SYNOPSIS
Starts rLoader users on a specific BotManager

.DESCRIPTION
Starts rLoader users on the specified BotManager

.OUTPUTS
Launcher launched requested users or did not, true or false. XML Object.

.NOTES
Make sure you have used Connect-Automai before you run this command

.EXAMPLE
Start-LoaderUsers -authHeader $token -automaiServer AUTOMAI-01.ctxlab.local -automaiPort 8888 -number_Of_Rusers 1 -launch_Delay 5
Starts 1 rloader on all botmanagers with a launch delay of 5 seconds

Start-LoaderUsers -authHeader $token -automaiServer AUTOMAI-01.ctxlab.local -automaiPort 8888 -number_Of_Rusers 1 -launch_Delay 5 -BotManagers "botmanager-01,botmanager-03"
Starts 1 rloader on botmanagers 01 and 03 only

Returns True or False
#>

Function Start-LoaderUsers {
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
        [Parameter(Mandatory=$false, HelpMessage = "Name of the BotManager to start users on")]
        [ValidateNotNullOrEmpty()]
        [string]$botManagers,
        [Parameter(Mandatory=$true, HelpMessage = "Numbers or Rusers to start")]
        [ValidateNotNullOrEmpty()]
        $number_Of_Rusers,
        [Parameter(Mandatory=$false, HelpMessage = "The delay between launching rLoader users")]
        [ValidateNotNullOrEmpty()]
        $launch_Delay,
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
$resourceUri = "$($protocol)$($automaiServer):$($automaiPort)/api/loader/startrloader/"

if (([String]::IsNullOrEmpty($botManagers))) {
    $post_Body = @{
        rusers_count = $number_Of_Rusers
        launch_delay = $launch_Delay
    }
} else {
    $post_Body = @{
        rusers_count = $number_Of_Rusers
        launch_delay = $launch_Delay
        bot_hosts = "$($botManagers | Out-String -Stream),"
    }
}

try {                
    #Write-Host "Attempting to connect to $resourceUri"
    $response = Invoke-RestMethod -Method Post -Uri $resourceUri -Headers $authHeader -Body $post_Body -ContentType "application/x-www-form-urlencoded"
} catch {
    if ($detailedOutput) {
        Write-Host $_
    }   
    Write-Host "There was an error connecting to the automai server, check if your server is SSL secured and that all the details are correct"
}

Return $response.root.started

}