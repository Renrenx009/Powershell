# 1)Write-Output 'Hello World!'

$name = Read-Host -Prompt "Please enter your name"
Write-Output "Congratulations $name! You have written your first code with PowerShell!"


# 2a)View the profile of the current powershell
$Profile | Select-Object *


# 2b)Create a profile for the current user and the current host by running the command New-Item
New-Item `
  -ItemType "file" `
  -Value 'Write-Host "Hello <replace with your name>, welcome back" -foregroundcolor Green ' `
  -Path $Profile.CurrentUserCurrentHost -Force


# 3a)Locate the Profile Path: Use the following command to find the path of the profile file
$Profile.CurrentUserCurrentHost


# 3b)Delete the Profile File: Use the Remove-Item cmdlet to delete the profile file:
Remove-Item -Path $Profile.CurrentUserCurrentHost -Force


# 4_______________________________________________________________________________________4

#Here's a basic outline of a script that you can use to achieve this task. 
#This example uses PowerShell to extract the approved purchase orders (POs) from the previous day and move them to the appropriate folders. 
#You can schedule this script to run daily using Task Scheduler.

#Steps to Schedule the Script:
#1.Save the Script: Save the above script as MoveApprovedPOs.ps1.
#2.Open Task Scheduler: Open Task Scheduler on your computer.
#3.Create a New Task: Click on "Create Task" and give it a name.
#4.Set Triggers: Go to the "Triggers" tab and set it to run daily at your preferred time.
#5.Set Actions: Go to the "Actions" tab and set it to start a program. In the "Program/script" field, enter powershell.exe and in the "Add arguments" field, enter -File "C:\Path\To\MoveApprovedPOs.ps1".
#6.Finish: Click OK to save the task.
#This script assumes that the approved POs are named in a way that includes the date and either "Buyer" or "SalesOrder" in the filename. You may need to adjust the script to fit your specific file naming conventions and folder paths.


# Define the source and destination folders
$sourceFolder = "C:\Path\To\ApprovedPOs"
$buyerFolder = "C:\Path\To\A-Purchase_Order\Buyer"
$salesOrderFolder = "C:\Path\To\A-Purchase_Order\SalesOrder"

# Get the date for the previous day
$yesterday = (Get-Date).AddDays(-1).ToString("yyyyMMdd")

# Get the list of approved POs from the previous day
$approvedPOs = Get-ChildItem -Path $sourceFolder -Filter "*$yesterday*.pdf"

# Move the approved POs to the appropriate folders
foreach ($po in $approvedPOs) {
    if ($po.Name -match "Buyer") {
        Move-Item -Path $po.FullName -Destination $buyerFolder
    } elseif ($po.Name -match "SalesOrder") {
        Move-Item -Path $po.FullName -Destination $salesOrderFolder
    }
}

# Log the operation
$logFile = "C:\Path\To\Log\PO_Log.txt"
Add-Content -Path $logFile -Value "Moved $($approvedPOs.Count) POs on $(Get-Date)"

#4________________________________________________________________________________________4




