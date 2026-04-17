$folders = @(
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Service Worker\CacheStorage",
    "$env:APPDATA\Code\Cache",
    "$env:APPDATA\Code\CachedData",
    "$home\Downloads\*.zip",
    "$home\Downloads\*.rar"
)

foreach($f in $folders){
    if(Test-Path $f){
        Write-Host "Limpiando: $f"
        Remove-Item -Path $f -Recurse -Force -ErrorAction SilentlyContinue
    }
}
