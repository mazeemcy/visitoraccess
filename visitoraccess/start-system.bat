@echo off
REM ============================================
REM Visitor Access Control System - Windows Start
REM ============================================
REM This script starts all required services

title Visitor Access Control System - Starting... 
color 0A

echo. 
echo ╔════════════════════════════════════════════════════════╗
echo ║  Visitor Access Control System - Windows Startup       ║
echo ║  @mazeemcy - 2026-01-15                               ║
echo ╚═════════════════════════════════════════════════════��══╝
echo.

REM Check if project folder exists
if not exist "backend\app\main.py" (
    color 0C
    echo [ERROR] This script must be run from project root folder! 
    echo Expected structure:
    echo   - backend\app\main.py
    echo   - frontend\package.json
    pause
    exit /b 1
)

REM Check Python
echo [1/5] Checking Python installation...
python --version > nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] Python is not installed or not in PATH! 
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo [✓] Python %PYTHON_VERSION% found

REM Check Node.js
echo [2/5] Checking Node.js installation...
node --version > nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] Node.js is not installed or not in PATH!
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)
for /f %%i in ('node --version 2^>^&1') do set NODE_VERSION=%%i
echo [✓] Node.js %NODE_VERSION% found

REM Check PostgreSQL
echo [3/5] Checking PostgreSQL installation...
psql --version > nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] PostgreSQL is not installed or not in PATH!
    echo Download from: https://www.postgresql.org/download/windows/
    pause
    exit /b 1
)
for /f "tokens=3" %%i in ('psql --version 2^>^&1') do set PG_VERSION=%%i
echo [✓] PostgreSQL %PG_VERSION% found

REM Check PostgreSQL service
echo [4/5] Checking PostgreSQL service... 
sc query "PostgreSQL" > nul 2>&1
if %errorlevel% neq 0 (
    echo [! ] PostgreSQL service not found.  Checking alternate names...
    sc query "PostgreSQL15" > nul 2>&1
    if %errorlevel% neq 0 (
        color 0E
        echo [WARNING] Could not verify PostgreSQL service status
        echo [INFO] Please ensure PostgreSQL is running
    )
) else (
    echo [✓] PostgreSQL service found
)

REM Create venv if not exists
echo [5/5] Checking backend virtual environment...
if not exist "backend\venv" (
    echo [! ] Virtual environment not found. Creating...
    cd backend
    python -m venv venv
    cd ..
    echo [✓] Virtual environment created
) else (
    echo [✓] Virtual environment found
)

echo. 
echo ╔════════════════════════════════════════════════════════╗
echo ║  All prerequisites verified!                           ║
echo ║  Starting services...                                  ║
echo ╚════════════════════════════════════════════════════════╝
echo.

REM Start Backend
echo [! ] Starting Backend (FastAPI) on port 8000...
echo [!] A new window will open - keep it running
timeout /t 2 > nul
start "Visitor Control - Backend (FastAPI)" cmd /k "cd backend && venv\Scripts\activate && python -m uvicorn app. main:app --reload --host 0.0.0.0 --port 8000"

REM Wait for backend to start
timeout /t 3 > nul

REM Start Frontend
echo [!] Starting Frontend (React) on port 3000...
echo [!] A new window will open - keep it running
echo [!] Browser will open automatically to http://localhost:3000
timeout /t 2 > nul
start "Visitor Control - Frontend (React)" cmd /k "cd frontend && npm start"

REM Display info
echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║  Services are starting...                              ║
echo ║                                                        ║
echo ║  Frontend:   http://localhost:3000                      ║
echo ║  Backend:   http://localhost:8000                      ║
echo ║  API Docs:  http://localhost:8000/docs                 ║
echo ║                                                        ║
echo ║  Wait 10-15 seconds for services to fully start        ║
echo ║                                                        ║
echo ║  Keep all windows open while using the system          ║
echo ║  Close any window to stop that service                 ║
echo ║                                                        ║
echo ║  Troubleshooting:                                      ║
echo ║  - If port already in use:  Close other apps           ║
echo ║  - If connection refused: Restart PostgreSQL           ║
echo ║  - Check . env files in backend and frontend            ║
echo ║                                                        ║
echo ║  GitHub: github.com/mazeemcy/visitor-access-control    ║
echo ╚════════════════════════════════════════════════════════╝
echo.

pause