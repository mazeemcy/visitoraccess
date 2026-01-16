# Visitor Access Control System

A complete, production-ready visitor management system integrated with Hikvision access controllers.

## Features

- âœ… Hikvision Integration
- âœ… Visitor Management with QR Codes
- âœ… Real-time Access Control
- âœ… Zone Management
- âœ… Live Events Monitoring
- âœ… Advanced Reporting

## Quick Start

### Windows (No Docker)

1. Install: Python 3.10+, Node.js 16+, PostgreSQL
2. Backend: `cd backend && python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt`
3. Create a `.env` file in `backend/` (see `.env.example`)
4. Frontend: `cd frontend && npm install`
5. Start Backend: `python -m uvicorn app.main:app --reload`
6. Start Frontend: `npm start`

#### Windows — Automated prerequisites installer (recommended)

If you're on Windows you can run the bundled installer script to set up common prerequisites and install project dependencies automatically:

- Run as Administrator: `scripts\install-prereqs-windows.bat`
- What it does: installs Python 3.12 (if missing), Node.js LTS, Docker Desktop (optional), Rust (for building some Python extensions), creates the backend `venv` and installs `backend/requirements.txt`, and runs `npm ci` in the frontend when possible.
- Notes:
  - The script uses `winget` for automated installs; if `winget` is unavailable it will advise manual installs.
  - It is idempotent and safe to re-run. After the script completes, activate the backend venv and run the app as listed above.


> The backend exposes OpenAPI docs at `/docs` when running.

## Auth & API

- Register a user: `POST /api/auth/register` with JSON `{ "email": "you@example.com", "password": "secret" }`
- Get a token: `POST /api/auth/token` using `application/x-www-form-urlencoded` with `username` and `password` fields (OAuth2 Password flow)
- Protected routes: `/api/visitors`, `/api/controllers` require a Bearer token

## Migrations

- Alembic is configured under `backend/alembic`. After setting `DATABASE_URL` in `.env`, run:

```bash
cd backend
alembic revision --autogenerate -m "init"
alembic upgrade head
```

See `backend/alembic/README.md` for details.

See WINDOWS_INSTALL_GUIDE.md for more details.

## Pre-commit hooks

We use `pre-commit` to run quick checks locally before commits (flake8, yaml checks, whitespace fixes).

To enable hooks locally:

```bash
# from repository root (recommended inside your Python venv)
cd backend
pip install -r requirements.txt
cd ..
pre-commit install
# option: to run against all files once
pre-commit run --all-files
```
