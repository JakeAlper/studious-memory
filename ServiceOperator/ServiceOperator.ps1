### $searchString = string to search against all existing service names
### $operation    = string to pass intended operation: 'Start', 'Stop', 'Restart', or 'AggroRestart'
function WaitUntilService($searchString, $operation) {
    foreach($service in (Get-Service -Name $searchString)) { ### Get all services where Name matches $searchString and loop through each of them
        $status = ''
        $message = ''

        switch ($operation) {
            'Start' { ### Start operation
                Start-Service $service
                $status = 'Running'
                $message = "Service `"$($service.Name)`" started. " ### Output success message
                break
            }
            'Stop' { ### Stop operation
                Stop-Service $service
                $status = 'Stopped'
                $message = "Service `"$($service.Name)`" stopped. " ### Output success message
                break
            }
            'Restart' { ### Restart operation
                Restart-Service $service
                $status = 'Running'
                $message = "Service `"$($service.Name)`" restarted. " ### Output success message
                break
            }
            'AggroRestart' { ### Aggressive restart operation
                Stop-Service $service
                Start-Sleep -seconds 5
                Start-Service $service
                $status = 'Running'
                $message = "Service `"$($service.Name)`" aggressively restarted. " ### Output success message
                break
            }
            Default { ### Probably something went wrong
                Write-Host 'Error, try again...'
                continue
            }
        }
        if ($status) { ### If status and message are set, wait for service to reach intended status and then output success message
            $service.WaitForStatus($status, '00:00:30')
            Write-Host $message
        }
    }
}

### Function calls and examples
WaitUntilService 'EABackgroundService' 'Restart'
# WaitUntilService 'EABackgroundService' 'Start'
# WaitUntilService 'EABackgroundService' 'Stop'
# WaitUntilService 'EABackgroundService' 'AggroRestart'

### Wait for user input before closing
Write-Host 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');