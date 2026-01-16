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
3. Frontend: `cd frontend && npm install`
4. Start Backend: `python -m uvicorn app.main:app --reload`
5. Start Frontend: `npm start`

See WINDOWS_INSTALL_GUIDE.md for details.

## Documentation

- WINDOWS_INSTALL_GUIDE. md - Complete Windows setup
- QUICKSTART.md - Quick reference
- API Docs at http://localhost:8000/docs
