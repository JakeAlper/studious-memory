### Check if launched with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  ### Relaunch Terminal as an elevated process
  Start-Process pwsh.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

param (
    [string]$scriptPath = "C:\Users\Jacob\Dropbox (Personal)\Desktop\Code\PowerShell\ServiceOperator\ServiceOperator.ps1"
)

### Launch the script with elevated privileges
& $scriptPath