Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   TIER-1 IT SYSTEM HEALTH CHECK" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Hostname and User info
Write-Host "`n[+] System Information:" -ForegroundColor Yellow
Write-Host "Machine Name : $env:COMPUTERNAME"
Write-Host "Current User : $env:USERNAME"
Write-Host "OS Version   : $( (Get-CimInstance Win32_OperatingSystem).Caption )"

# 2. Disk Space Audit
Write-Host "`n[+] Storage Status:" -ForegroundColor Yellow
Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Free(GB)";Expression={[math]::round($_.Free / 1GB, 2)}}, @{Name="Used(GB)";Expression={[math]::round($_.Used / 1GB, 2)}} | Format-Table -AutoSize

# 3. Top 3 CPU Consuming Processes
Write-Host "[+] Top 3 CPU Intensive Processes:" -ForegroundColor Yellow
Get-Process | Sort-Object CPU -Descending | Select-Object -First 3 -Property Id, ProcessName, @{Name="CPU(s)";Expression={[math]::round($_.CPU, 2)}} | Format-Table -AutoSize

# 4. Network Connectivity Test (DNS 8.8.8.8)
Write-Host "[+] Network Connectivity Check (Gateway & DNS):" -ForegroundColor Yellow
$pingTest = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
if ($pingTest) {
    Write-Host "Status: ONLINE (Internet access verified)" -ForegroundColor Green
} else {
    Write-Host "Status: OFFLINE (Check local network connection)" -ForegroundColor Red
}

# 5. Recent System Critical / Error Events (Last 24 Hours)
Write-Host "`n[+] Recent Critical & Error Events (Last 24 Hours):" -ForegroundColor Yellow
$recentErrors = Get-WinEvent -FilterHashtable @{LogName='System'; Level=@(1,2); StartTime=(Get-Date).AddDays(-1)} -MaxEvents 3 -ErrorAction SilentlyContinue
if ($recentErrors) {
    $recentErrors | Select-Object TimeCreated, LevelDisplayName, Id, Message | Format-Table -AutoSize
} else {
    Write-Host "Status: CLEAN (No critical errors reported in the last 24 hours)" -ForegroundColor Green
}

Write-Host "`n==========================================" -ForegroundColor Cyan
