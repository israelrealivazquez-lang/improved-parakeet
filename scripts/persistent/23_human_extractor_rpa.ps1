Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ROBOT HUMANOIDE NEXUS V3.1
$CaptureScript = "C:\Users\Lenovo\manual_capture.ps1"
$Delay = 12
$Shell = New-Object -ComObject WScript.Shell

$signature = '[DllImport("user32.dll")] public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);'
$mouse = Add-Type -MemberDefinition $signature -Name "Win32Mouse" -Namespace Win32 -PassThru

function Move-And-Click($x, $y) {
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    Start-Sleep -Seconds 2
    $mouse::mouse_event(0x0002, 0, 0, 0, 0) # Down
    Start-Sleep -Milliseconds 200
    $mouse::mouse_event(0x0004, 0, 0, 0, 0) # Up
    Start-Sleep -Seconds $Delay
    powershell -ExecutionPolicy Bypass -File $CaptureScript
}

function Human-Scroll {
    [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
    Start-Sleep -Seconds 3
    [System.Windows.Forms.SendKeys]::SendWait("{PGDN}")
    Start-Sleep -Seconds $Delay
    powershell -ExecutionPolicy Bypass -File $CaptureScript
}

function Send-Human-Keys($keys) {
    [System.Windows.Forms.SendKeys]::SendWait($keys)
    Start-Sleep -Seconds $Delay
    powershell -ExecutionPolicy Bypass -File $CaptureScript
}

Write-Output "--- INICIO ---"
$Shell.AppActivate("Google Chrome")
Start-Sleep -Seconds 5

# 1. ChatGPT
Move-And-Click 505 27
Move-And-Click 160 160
Human-Scroll
Send-Human-Keys "^a"
Send-Human-Keys "^c"

# 2. Drive
Move-And-Click 900 27
Send-Human-Keys "^v"

# 3. Gemini
Move-And-Click 272 27
Move-And-Click 160 300
Human-Scroll
Send-Human-Keys "^a"
Send-Human-Keys "^c"

# 4. Drive (Again)
Move-And-Click 900 27
Send-Human-Keys "^v"

Write-Output "--- FIN ---"
