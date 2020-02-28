# Practice for the event registration. This is the equivalent of `dir /A:D %TEMP%\SDIAG_*`
Get-CimInstance -ClassName Win32_Directory -Filter "Drive='c:' AND Path='$("$($Env:TEMP.Substring(2))\".Replace('\','\\'))' AND FileName LIKE 'SDIAG_________-____-____-____-____________'"

$EventName = 'DirectoryWatcher'

Register-CimIndicationEvent -Query "SELECT TargetInstance FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA 'Win32_Directory' AND TargetInstance.Drive='C:' AND TargetInstance.Path='$("$($Env:TEMP.Substring(2))\".Replace('\','\\'))' AND TargetInstance.FileName LIKE 'SDIAG_________-____-____-____-____________'" -Action {
    # If you were weaponizing a Troubleshooting Pack hijack, this is where you would copy
    # your payload @($EventArgs.NewEvent.TargetInstance.Name)\Targetfile.ps1
    
    Write-Host "New directory created: $($EventArgs.NewEvent.TargetInstance.Name)"
    Unregister-Event -SourceIdentifier $EventSubscriber.SourceIdentifier
} -SourceIdentifier $EventName



