@echo off
REM Stop all services

title Stopping Visitor Access Control System... 
color 0A

echo. 
echo Stopping services... 
echo.

REM Kill backend (uvicorn)
taskkill /FI "WINDOWTITLE eq Visitor Control - Backend*" /T /F > nul 2>&1
echo [✓] Backend stopped

REM Kill frontend (Node)
taskkill /FI "WINDOWTITLE eq Visitor Control - Frontend*" /T /F > nul 2>&1
echo [✓] Frontend stopped

REM Alternative: Kill by process name if above doesn't work
taskkill /IM python.exe /F > nul 2>&1
taskkill /IM node.exe /F > nul 2>&1

echo.
echo [✓] All services stopped
echo. 
echo Database (PostgreSQL) is still running
echo To fully restart, close this window and run:  start-system.bat
echo.
pause