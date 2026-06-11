# GlazeWM: Disable Windows 11 native Win+* shortcuts
# Run this in PowerShell AS ADMINISTRATOR
# Reboot required after changes

Write-Host "=== GlazeWM: Disable Windows Win+* Shortcuts ===" -ForegroundColor Cyan
Write-Host ""

$needsReboot = $false

# ──────────────────────────────────────────────
# OPTION 1: Disable Win+L (lock screen) ONLY
# ──────────────────────────────────────────────
$lockPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$lockName = "DisableLockWorkstation"

Write-Host "[1/2] Disabling Win+L (lock screen)..." -ForegroundColor Yellow

if (-not (Test-Path $lockPath)) {
    New-Item -Path $lockPath -Force | Out-Null
}

$currentLock = Get-ItemProperty -Path $lockPath -Name $lockName -ErrorAction SilentlyContinue
if ($currentLock.$lockName -eq 1) {
    Write-Host "  Win+L already disabled." -ForegroundColor Green
} else {
    New-ItemProperty -Path $lockPath -Name $lockName -Value 1 -PropertyType DWORD -Force | Out-Null
    Write-Host "  Win+L disabled. (Revert: set DisableLockWorkstation to 0)" -ForegroundColor Green
    $needsReboot = $true
}

# ══════════════════════════════════════════════
# OPTION 2: Disable ALL Win+* shortcuts
# ══════════════════════════════════════════════
# This is needed because your glazewm config uses many Win+* bindings:
#   lwin+1..9  → workspace switching (conflicts with taskbar pinned apps)
#   lwin+d     → recent workspace (conflicts with Show Desktop)
#   lwin+s     → next workspace (conflicts with Search)
#   lwin+a     → prev workspace (conflicts with Quick Actions)
#   lwin+v     → toggle tiling direction (conflicts with Clipboard History)
#   lwin+space → cycle focus (conflicts with input language switch)
#   lwin+enter → launch terminal (conflicts with Narrator)
#   lwin+f     → toggle fullscreen (conflicts with Feedback Hub)
#   lwin+r     → resize mode (conflicts with Run dialog)
#   lwin+t     → toggle tiling (conflicts with taskbar cycling)
#   lwin+m     → minimize (conflicts with Minimize All)
# ──────────────────────────────────────────────

$noWinKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$noWinKeyName = "NoWinKeys"

Write-Host ""
Write-Host "[2/2] Disabling ALL Win+* shortcuts..." -ForegroundColor Yellow
Write-Host "  This prevents Windows from intercepting Win+1..9, Win+D, Win+S,"
Write-Host "  Win+A, Win+V, Win+Space, Win+Enter, Win+F, Win+R, Win+T, Win+M"
Write-Host "  so glazewm can handle all Win+* combinations."
Write-Host ""

$currentNoWin = Get-ItemProperty -Path $noWinKeyPath -Name $noWinKeyName -ErrorAction SilentlyContinue
if ($currentNoWin.$noWinKeyName -eq 1) {
    Write-Host "  All Win+* shortcuts already disabled." -ForegroundColor Green
} else {
    New-ItemProperty -Path $noWinKeyPath -Name $noWinKeyName -Value 1 -PropertyType DWORD -Force | Out-Null
    Write-Host "  All Win+* shortcuts disabled. (Revert: set NoWinKeys to 0)" -ForegroundColor Green
    $needsReboot = $true
}

Write-Host ""
Write-Host "=== DONE ===" -ForegroundColor Cyan

if ($needsReboot) {
    Write-Host "REBOOT REQUIRED for changes to take effect." -ForegroundColor Red
    Write-Host "After reboot, run glazewm and test lwin+l, lwin+k, lwin+1..9, etc." -ForegroundColor Yellow
} else {
    Write-Host "No changes needed - all shortcuts already disabled." -ForegroundColor Green
}

Write-Host ""
Write-Host "SIDE EFFECTS TO BE AWARE OF:" -ForegroundColor Magenta
Write-Host "  • Win+L no longer locks the screen → use Ctrl+Alt+Del → Lock instead"
Write-Host "  • Win+1..9 no longer opens taskbar pinned apps"
Write-Host "  • Win+D no longer shows desktop"
Write-Host "  • Win+R no longer opens Run dialog → use Ctrl+Shift+Enter for terminal"
Write-Host "  • Win+E still works (not bound in glazewm)"
Write-Host "  • Win+X still works (not bound in glazewm)"
Write-Host ""
Write-Host "TO REVERT ALL CHANGES:"
Write-Host "  Remove-ItemProperty -Path '$lockPath' -Name '$lockName' -ErrorAction SilentlyContinue"
Write-Host "  Remove-ItemProperty -Path '$noWinKeyPath' -Name '$noWinKeyName' -ErrorAction SilentlyContinue"
Write-Host "  Then reboot."
