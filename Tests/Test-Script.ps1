$automaiServer = "AUTOMAI-01.ctxlab.local"
$automaiPort = "8888"
$automaiUsername = "admin"
$automaiPassword = "automai"
$useSSL = $false

if (!$imported) {
    $imported = Import-Module -Name 'C:\Users\jedth\Leee Jeffries\Leee Jeffries Team Site - Documents\Clients\Automai\Source\PSAutomaiSuite\PSAutomaiSuite.psm1' -PassThru
}

if (!$authHeader) {
    if ($useSSL) {
        $authHeader = Connect-Automai -automaiServer $automaiServer -automaiPort $automaiPort -automaiUsername $automaiUsername -automaiPassword $automaiPassword -UseSSL
    } else {
        $authHeader = Connect-Automai -automaiServer $automaiServer -automaiPort $automaiPort -automaiUsername $automaiUsername -automaiPassword $automaiPassword
    }
}

$liveRloaderUsers = Get-LoaderUsers -authHeader $authHeader -automaiServer AUTOMAI-01.ctxlab.local -automaiPort 8888

Write-Host "The number of rLoader users currently active is $liveRloaderUsers"


