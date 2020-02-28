$EventName = 'PowerShellHostProcessWatcher'

Register-CimIndicationEvent -Query "SELECT FileName, ProcessID FROM Win32_ModuleLoadTrace WHERE FileName LIKE '%System.Management.Automation%'" -Action {

    Write-Host @"
PowerShell host process loaded!
Process ID: $($EventArgs.NewEvent.ProcessID)
File path:  $($EventArgs.NewEvent.FileName)
"@

    Unregister-Event -SourceIdentifier $EventSubscriber.SourceIdentifier
} -SourceIdentifier $EventName
