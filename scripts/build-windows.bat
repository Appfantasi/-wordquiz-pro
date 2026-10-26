@echo off
cd /d "%~dp0.."
where node >nul 2>nul
if errorlevel 1 (
  echo Serve Node.js. Installalo con:  winget install OpenJS.NodeJS.LTS
  pause
  exit /b 1
)
call npm install
if errorlevel 1 (pause & exit /b 1)
call npm run win
if errorlevel 1 (pause & exit /b 1)
echo.
echo Fatto. Gli .exe sono nella cartella dist
pause
