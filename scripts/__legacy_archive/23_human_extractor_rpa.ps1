Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 🤖 ROBOT HUMANOIDE NEXUS V4.0 (SMART EDITION)
$CaptureScript = "C:\Users\Lenovo\manual_capture.ps1"
$MaxWait = 15 # Máximo tiempo de espera en segundos
$Shell = New-Object -ComObject WScript.Shell

$signature = '[DllImport("user32.dll")] public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);'
$mouse = Add-Type -MemberDefinition $signature -Name "Win32Mouse" -Namespace Win32 -PassThru

function Wait-For-Action {
    param($actionKeys = "^c")
    Write-Host "[*] Ejecutando acción e iniciando Smart Wait..." -ForegroundColor Cyan
    $oldClipboard = [System.Windows.Forms.Clipboard]::GetText()
    [System.Windows.Forms.SendKeys]::SendWait($actionKeys)
    
    $start = Get-Date
    while (((Get-Date) - $start).TotalSeconds -lt $MaxWait) {
        $currentClipboard = [System.Windows.Forms.Clipboard]::GetText()
        if ($currentClipboard -ne $oldClipboard -and $currentClipboard -ne "") {
            Write-Host "[+] Acción detectada en $((Get-Date) - $start) segundos." -ForegroundColor Green
            return $true
        }
        Start-Sleep -Milliseconds 500
    }
    Write-Host "[!] Timeout: No se detectó cambio en el portapapeles." -ForegroundColor Yellow
    return $false
}

function Move-And-Click($x, $y) {
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    Start-Sleep -Milliseconds 500
    $mouse::mouse_event(0x0002, 0, 0, 0, 0) # Down
    Start-Sleep -Milliseconds 100
    $mouse::mouse_event(0x0004, 0, 0, 0, 0) # Up
    Start-Sleep -Seconds 2
}

Write-Output "--- NEXUS SMART RPA START ---"
$Shell.AppActivate("Google Chrome")
Start-Sleep -Seconds 2

# 1. ChatGPT
Move-And-Click 505 27
Move-And-Click 160 160
[System.Windows.Forms.SendKeys]::SendWait("^a")
if (Wait-For-Action "^c") {
    powershell -ExecutionPolicy Bypass -File $CaptureScript
}

# 2. Drive (Pegar)
Move-And-Click 900 27
[System.Windows.Forms.SendKeys]::SendWait("^v")
Start-Sleep -Seconds 1

# 3. Gemini
Move-And-Click 272 27
Move-And-Click 160 300
[System.Windows.Forms.SendKeys]::SendWait("^a")
if (Wait-For-Action "^c") {
    powershell -ExecutionPolicy Bypass -File $CaptureScript
}

# 4. Drive (Pegar)
Move-And-Click 900 27
[System.Windows.Forms.SendKeys]::SendWait("^v")

Write-Output "--- NEXUS SMART RPA FIN ---"

