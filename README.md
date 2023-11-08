# Automai PowerShell Module Documentation

# Introduction
This PowerShell module is available on the PowerShell Gallery, its designed to enable automation of some of the main functions available to users of the Automai software.

Please log any issues with the module to the support team to be addressed within the Automai organisation.

# General
## Connect-Automai

### SYNOPSIS
Connects to the Automai Server API to generate a token.

### DESCRIPTION
This cmdlet connects to the Automai REST endpoint for Director to obtain a token for further API calls.

### OUTPUTS
API token as a string.

### NOTES
- If there is an issue grabbing the API token, the script will fail.

### SYNTAX
```powershell
Connect-Automai
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-automaiUsername] <String>
    [-automaiPassword] <String>
    [-UseSSL]
    [-detailedOutput]
```

---
## Get-JobStatus

### SYNOPSIS
Get the current status of a job.

### DESCRIPTION
This cmdlet allows you to specify the ID of a job obtained by `Get-LoaderReport` to retrieve the current status of the job.

### OUTPUTS
Returns the status of the job.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Get-JobStatus
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-jobID <String>]
    [-detailedOutput]
```
---
## Set-Schedule

### SYNOPSIS
Sets a schedule as active or inactive.

### DESCRIPTION
This cmdlet allows you to set a schedule as inactive or active, which can be used to stop or start automated schedules.

### OUTPUTS
Returns `TRUE` on success.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Set-Schedule
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-schedule <String>]
    [-flag <String>]
    [-detailedOutput]
```
---

# Loader

## Get-LoaderPlan

**SYNOPSIS**

Get the current status of a test plan.

**DESCRIPTION**

This cmdlet retrieves the current status of a test plan specified by its ID. It requires authentication through the `Connect-Automai` cmdlet before use.

**OUTPUTS**

Returns the status of the test plan.

**NOTES**

Make sure you have used `Connect-Automai` before you run this command.

**SYNTAX**
```powershell
Get-LoaderPlan
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-testPlanID] <String>
    [-testRunID <Int32>]
    [-detailedOutput]
```
---

## Get-LoaderReport

### SYNOPSIS
Generate a test plan report.

### DESCRIPTION
This cmdlet schedules a job to generate a test plan report specified by its ID. It requires authentication through the `Connect-Automai` cmdlet before use.

### OUTPUTS
Returns an object with the Job ID to check with further calls and the URL of the report for download.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.
- You need to run `Get-JobStatus` to see when it's complete.

### SYNTAX
```powershell
Get-LoaderReport
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-testPlanID] <String>
    [-testRunID <Int32>]
    [-reportType <String>]
    [-detailedOutput]
```
---
## Get-LoaderUsers

### SYNOPSIS
Checks connected rLoader Users.

### DESCRIPTION
This cmdlet returns the number of rLoader users that are currently connected. It requires authentication through the `Connect-Automai` cmdlet before use.

### OUTPUTS
Number of rLoader users in an XML Object.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Get-LoaderUsers
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-detailedOutput]
```
---
## Play-LoaderPlan

### SYNOPSIS
Schedules and plays a test plan.

### DESCRIPTION
This cmdlet allows you to specify the ID of a test plan to start the test plan.

### OUTPUTS
Returns the ID of the scheduled test.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Play-LoaderPlan
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-testPlanID <String>]
    [-testPlanUsers <Int32>]
    [-testPlanSteadyState <String>]
    [-testPlanSteadyStateTime]
    [-testPlanIterations <Int32>]
    [-testPlanNotes <String>]
    [-detailedOutput]
```
---
## Start-LoaderUsers

### SYNOPSIS
Starts rLoader users on a specific BotManager.

### DESCRIPTION
This cmdlet allows you to start rLoader users on the specified BotManager.

### OUTPUTS
Launcher launched requested users or did not, true or false, as an XML Object.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Start-LoaderUsers
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-botManagers <String>]
    [-number_Of_Rusers <Int32>]
    [-launch_Delay]
    [-detailedOutput]
```
---
## Stop-LoaderPlan

### SYNOPSIS
Stop the specified test run.

### DESCRIPTION
This cmdlet allows you to stop a test plan run by specifying its ID.

### OUTPUTS
Returns success if the stop succeeded.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Stop-LoaderPlan
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-testPlanID] <String>
    [-detailedOutput]
```
---
# Watcher

## Get-WatcherData

### SYNOPSIS
Gets Watcher report data.

### DESCRIPTION
This cmdlet retrieves Watcher report data based on the specified timestamp and other optional parameters.

### OUTPUTS
Returns report information.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Get-WatcherData
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-timestamp] <String>
    [-last_report_id <String>]
    [-location_name <String>]
    [-watcher_ids <String>]
    [-detailedOutput]
```
---
# Worker/Tester

## Play-WorkerTesterFlow

### SYNOPSIS
Schedules and plays a worker or tester flow.

### DESCRIPTION
This cmdlet schedules and plays a worker or tester flow based on the specified flow ID.

### OUTPUTS
Returns success or failure.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Play-WorkerTesterFlow
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-flowID] <String>
    [-detailedOutput]
```
---
## Stop-WorkerTesterFlow

### SYNOPSIS
Stops a worker or tester flow.

### DESCRIPTION
This cmdlet stops a worker or tester flow based on the specified flow ID.

### OUTPUTS
Returns success or failure.

### NOTES
- Make sure you have used `Connect-Automai` before you run this command.

### SYNTAX
```powershell
Stop-WorkerTesterFlow
    [-authHeader] <Object>
    [-automaiServer] <String>
    [-automaiPort] <Int32>
    [-UseSSL]
    [-flowID] <String>
    [-detailedOutput]
```
