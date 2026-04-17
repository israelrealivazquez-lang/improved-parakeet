$folders = @("$home\Downloads", "$home\Documents", "$home\Desktop", "$env:LOCALAPPDATA")
Write-Host "BUSCANDO ARCHIVOS GIGANTES (+500MB)..."
foreach($f in $folders){
    if(Test-Path $f){
        Get-ChildItem -Path $f -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Length -gt 500MB } | Select-Object FullName, @{Name='Size(GB)';Expression={$_.Length / 1GB}}
    }
}
