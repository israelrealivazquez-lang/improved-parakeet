Set objShell = CreateObject("WScript.Shell")
' Launch the master persistence script hidden
' 0 = Hidden window, True = Wait for completion (optional, here we use False for background)
psCommand = "powershell.exe -ExecutionPolicy Bypass -File ""C:\Users\Lenovo\improved-parakeet\scripts\persistent\23_nexus_persist_everything.ps1"""
objShell.Run psCommand, 0, False
