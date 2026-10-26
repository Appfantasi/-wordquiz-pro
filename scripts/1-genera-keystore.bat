@echo off
cd /d "%~dp0.."
where keytool >nul 2>nul
if errorlevel 1 (
  echo Serve il Java JDK. Installalo con:  winget install EclipseAdoptium.Temurin.21.JDK
  echo Poi chiudi questa finestra e rilancia questo file.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0genera-keystore.ps1"
pause
