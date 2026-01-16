# 🪟 Windows Installation - Complete Guide

**For Windows 10/11 Users - No Docker Required**

---

## 📋 Quick Reference

| Task | Command | Location |
|------|---------|----------|
| **Install everything** | Run `start-system.bat` twice, then `WINDOWS_INSTALL_GUIDE.md` | Project root |
| **Start system** | Double-click `start-system.bat` | Project root |
| **Stop system** | Double-click `stop-system.bat` | Project root |
| **View API docs** | Open http://localhost:8000/docs | Browser |
| **Access app** | Open http://localhost:3000 | Browser |
| **Manual backend** | `venv\Scripts\activate` then `python -m uvicorn app.main:app --reload` | `backend/` folder |
| **Manual frontend** | `npm start` | `frontend/` folder |

---

## 🚀 **30-Second Quick Start** (First Time Only)

1. **Install prerequisites:**
   - Python 3.10+:  https://www.python.org/downloads/
   - Node.js 16+: https://nodejs.org/
   - PostgreSQL: https://www.postgresql.org/download/windows/
   - Git: https://git-scm.com/download/win

2. **Clone and setup:**
   ```powershell
   git clone https://github.com/mazeemcy/visitor-access-control.git
   cd visitor-access-control
   copy . env.example .env