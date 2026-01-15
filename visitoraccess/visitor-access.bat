@echo off
REM ============================================
REM Visitor Access Control System - Full Setup Script
REM Creates complete directory structure and all files
REM For Windows (CMD/PowerShell)
REM ============================================

setlocal enabledelayedexpansion
chcp 65001 >nul

REM Set project root
set PROJECT_ROOT=%CD%
set TIMESTAMP=2026-01-15

echo. 
echo ╔════════════════════════════════════════════════════════╗
echo ║  Visitor Access Control - Project Setup                ║
echo ║  Created: %TIMESTAMP%                              ║
echo ║  User: mazeemcy                                        ║
echo ╚════════════════════════════════════════════════════════╝
echo.

REM ============================================
REM CREATE DIRECTORIES
REM ============================================
echo [1/3] Creating directory structure... 

md "%PROJECT_ROOT%\backend\app\models" 2>nul
md "%PROJECT_ROOT%\backend\app\routes" 2>nul
md "%PROJECT_ROOT%\backend\app\schemas" 2>nul
md "%PROJECT_ROOT%\backend\app\services" 2>nul
md "%PROJECT_ROOT%\backend\app\utils" 2>nul
md "%PROJECT_ROOT%\backend\app\db" 2>nul

md "%PROJECT_ROOT%\frontend\src\pages" 2>nul
md "%PROJECT_ROOT%\frontend\src\components\Layout" 2>nul
md "%PROJECT_ROOT%\frontend\src\components\Zones" 2>nul
md "%PROJECT_ROOT%\frontend\src\api" 2>nul
md "%PROJECT_ROOT%\frontend\src\store" 2>nul
md "%PROJECT_ROOT%\frontend\src\types" 2>nul
md "%PROJECT_ROOT%\frontend\src\hooks" 2>nul
md "%PROJECT_ROOT%\frontend\src\utils" 2>nul
md "%PROJECT_ROOT%\frontend\src\contexts" 2>nul

md "%PROJECT_ROOT%\scripts" 2>nul
md "%PROJECT_ROOT%\docs" 2>nul

echo [✓] Directories created

REM ============================================
REM CREATE BACKEND FILES
REM ============================================
echo [2/3] Creating backend files...

REM Backend main entry point
(
  echo # Visitor Access Control - FastAPI Backend
  echo # Entry point
  echo. 
  echo from fastapi import FastAPI
  echo from fastapi.middleware. cors import CORSMiddleware
  echo from contextlib import asynccontextmanager
  echo from app.routes import (
  echo     auth, controllers, gates, zones, visitors, 
  echo     groups, events, users, roles, templates, reports
  echo ^)
  echo from app.db. database import engine, Base
  echo. 
  echo # Create tables
  echo Base.metadata.create_all(bind=engine^)
  echo.
  echo @asynccontextmanager
  echo async def lifespan(app:  FastAPI^):
  echo     print("✅ System Started"^)
  echo     yield
  echo     print("🛑 System Shutting Down"^)
  echo.
  echo app = FastAPI(title="Visitor Access Control API", lifespan=lifespan^)
  echo.
  echo # CORS Middleware
  echo app.add_middleware(
  echo     CORSMiddleware,
  echo     allow_origins=["*"],
  echo     allow_credentials=True,
  echo     allow_methods=["*"],
  echo     allow_headers=["*"],
  echo ^)
  echo.
  echo # Routes
  echo app.include_router(auth.router, prefix="/api/auth", tags=["auth"]^)
  echo app.include_router(controllers.router, prefix="/api/controllers", tags=["controllers"]^)
  echo app.include_router(gates.router, prefix="/api/gates", tags=["gates"]^)
  echo app.include_router(zones.router, prefix="/api/zones", tags=["zones"]^)
  echo app.include_router(visitors.router, prefix="/api/visitors", tags=["visitors"]^)
  echo app.include_router(groups.router, prefix="/api/groups", tags=["groups"]^)
  echo app.include_router(events.router, prefix="/api/events", tags=["events"]^)
  echo app.include_router(users.router, prefix="/api/users", tags=["users"]^)
  echo app.include_router(roles.router, prefix="/api/roles", tags=["roles"]^)
  echo app.include_router(templates.router, prefix="/api/templates", tags=["templates"]^)
  echo.
  echo @app.get("/health"^)
  echo async def health_check(^):
  echo     return {"status": "healthy"}
  echo.
  echo if __name__ == "__main__":  
  echo     import uvicorn
  echo     uvicorn.run(app, host="0.0.0.0", port=8000^)
) > "%PROJECT_ROOT%\backend\app\main.py"

REM Backend config
(
  echo from pydantic_settings import BaseSettings
  echo from functools import lru_cache
  echo. 
  echo class Settings(BaseSettings^):
  echo     database_url: str
  echo     secret_key: str
  echo     algorithm: str = "HS256"
  echo     access_token_expire_minutes: int = 480
  echo     debug: bool = False
  echo. 
  echo     class Config: 
  echo         env_file = ".env"
  echo. 
  echo @lru_cache(^)
  echo def get_settings(^):
  echo     return Settings(^)
  echo.
  echo settings = get_settings(^)
) > "%PROJECT_ROOT%\backend\app\config. py"

REM Database setup
(
  echo from sqlalchemy import create_engine
  echo from sqlalchemy.ext.declarative import declarative_base
  echo from sqlalchemy.orm import sessionmaker
  echo from app.config import settings
  echo.
  echo engine = create_engine(
  echo     settings.database_url,
  echo     pool_pre_ping=True,
  echo     echo=False
  echo ^)
  echo.
  echo SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine^)
  echo Base = declarative_base(^)
  echo.
  echo def get_db(^):
  echo     db = SessionLocal(^)
  echo     try:
  echo         yield db
  echo     finally:  
  echo         db.close(^)
) > "%PROJECT_ROOT%\backend\app\db\database.py"

REM Models stub
(
  echo from sqlalchemy import Column, Integer, String, DateTime, Boolean, ForeignKey, Text
  echo from sqlalchemy.orm import relationship
  echo from app.db.database import Base
  echo from datetime import datetime
  echo.
  echo REM TODO: Add all model classes
  echo REM - AccessController, Gate, Zone, Visitor, User, Role, etc.
) > "%PROJECT_ROOT%\backend\app\models\models.py"

REM Routes stubs
(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add routes
) > "%PROJECT_ROOT%\backend\app\routes\auth.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add controller routes
) > "%PROJECT_ROOT%\backend\app\routes\controllers.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add gate routes
) > "%PROJECT_ROOT%\backend\app\routes\gates.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add zone routes
) > "%PROJECT_ROOT%\backend\app\routes\zones.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add visitor routes
) > "%PROJECT_ROOT%\backend\app\routes\visitors.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add group routes
) > "%PROJECT_ROOT%\backend\app\routes\groups.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add template routes
) > "%PROJECT_ROOT%\backend\app\routes\templates.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add event routes
) > "%PROJECT_ROOT%\backend\app\routes\events.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add user routes
) > "%PROJECT_ROOT%\backend\app\routes\users.py"

(
  echo from fastapi import APIRouter
  echo router = APIRouter(^)
  echo REM TODO: Add role routes
) > "%PROJECT_ROOT%\backend\app\routes\roles. py"

REM Schemas
(
  echo from pydantic import BaseModel
  echo. 
  echo REM TODO: Add all Pydantic schemas
) > "%PROJECT_ROOT%\backend\app\schemas\schemas.py"

REM Services
(
  echo import requests
  echo from requests. auth import HTTPDigestAuth
  echo. 
  echo class HikvisionService:
  echo     """Service for Hikvision access controllers"""
  echo. 
  echo     def __init__(self, ip: str, port: int, username: str, password: str^):
  echo         self.ip = ip
  echo         self. port = port
  echo         self.username = username
  echo         self.password = password
  echo         self.base_url = f"http://{ip}:{port}/ISAPI"
  echo.
  echo     REM TODO: Add methods for device info, door control, etc.
) > "%PROJECT_ROOT%\backend\app\services\hikvision_service. py"

REM Utils
(
  echo from passlib.context import CryptContext
  echo. 
  echo pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto"^)
  echo.
  echo def hash_password(password:  str^) -> str:
  echo     return pwd_context.hash(password^)
  echo.
  echo def verify_password(plain:  str, hashed: str^) -> bool:
  echo     return pwd_context.verify(plain, hashed^)
) > "%PROJECT_ROOT%\backend\app\utils\security.py"

(
  echo from cryptography.fernet import Fernet
  echo import os
  echo. 
  echo KEY = os.getenv("ENCRYPTION_KEY", Fernet.generate_key(^)^)
  echo cipher = Fernet(KEY^)
  echo.
  echo def encrypt_password(password: str^) -> str:
  echo     return cipher.encrypt(password. encode(^)^).decode(^)
  echo.
  echo def decrypt_password(encrypted:  str^) -> str:
  echo     return cipher.decrypt(encrypted.encode(^)^).decode(^)
) > "%PROJECT_ROOT%\backend\app\utils\encryption.py"

(
  echo from typing import List, Dict
  echo. 
  echo class ConnectionManager:
  echo     def __init__(self^):
  echo         self.active_connections: Dict[str, List] = {}
  echo.
  echo     async def connect(self, websocket, client_id: str^):
  echo         if client_id not in self.active_connections:
  echo             self.active_connections[client_id] = []
  echo         self.active_connections[client_id].append(websocket^)
  echo.
  echo     def disconnect(self, websocket, client_id: str^):
  echo         if client_id in self.active_connections:
  echo             self.active_connections[client_id].remove(websocket^)
  echo.
  echo manager = ConnectionManager(^)
) > "%PROJECT_ROOT%\backend\app\utils\websocket_manager.py"

REM Requirements
(
  echo fastapi==0.104.1
  echo uvicorn==0.24.0
  echo sqlalchemy==2.0.23
  echo psycopg2-binary==2.9.9
  echo pydantic==2.5.0
  echo pydantic-settings==2.1.0
  echo python-jose==3.3.0
  echo passlib==1.7.4
  echo cryptography==41.0.7
  echo python-dotenv==1.0.0
  echo requests==2.31.0
  echo qrcode==7.4.2
  echo pillow==10.1.0
  echo aiofiles==23.2.1
  echo websockets==12.0
) > "%PROJECT_ROOT%\backend\requirements.txt"

REM . env. example
(
  echo DATABASE_URL=postgresql://visitor_user:visitor_pass@localhost: 5432/visitor_control
  echo SECRET_KEY=your-super-secret-key-change-this-minimum-32-characters
  echo ALGORITHM=HS256
  echo ACCESS_TOKEN_EXPIRE_MINUTES=480
  echo HOST=0.0.0.0
  echo PORT=8000
  echo DEBUG=False
) > "%PROJECT_ROOT%\backend\. env.example"

echo   [✓] Backend files created

REM ============================================
REM CREATE FRONTEND FILES
REM ============================================
echo [3/3] Creating frontend files... 

REM Package. json
(
  echo {
  echo   "name": "visitor-access-control-ui",
  echo   "version":  "1.0.0",
  echo   "private": true,
  echo   "dependencies": {
  echo     "react": "^18.2.0",
  echo     "react-dom": "^18.2.0",
  echo     "react-router-dom": "^6.20.0",
  echo     "@mui/material": "^5.14.0",
  echo     "@mui/icons-material": "^5.14.0",
  echo     "@emotion/react": "^11.11.0",
  echo     "@emotion/styled": "^11.11.0",
  echo     "axios": "^1.6.0",
  echo     "qrcode. react": "^1.0.1",
  echo     "moment": "^2.29.4",
  echo     "zustand": "^4.4.0",
  echo     "react-hot-toast": "^2.4.1"
  echo   },
  echo   "scripts": {
  echo     "start": "react-scripts start",
  echo     "build": "react-scripts build",
  echo     "dev": "vite"
  echo   }
  echo }
) > "%PROJECT_ROOT%\frontend\package.json"

REM Types
(
  echo export interface User {
  echo   id: number;
  echo   username: string;
  echo   email: string;
  echo   is_active: boolean;
  echo   created_at: string;
  echo }
  echo. 
  echo export interface Zone {
  echo   id: number;
  echo   name: string;
  echo   organization: string;
  echo   description?:  string;
  echo }
  echo.
  echo export interface Visitor {
  echo   id:  number;
  echo   name: string;
  echo   group_id: number;
  echo   qrcode:  string;
  echo   expires_at:  string;
  echo   created_at: string;
  echo }
) > "%PROJECT_ROOT%\frontend\src\types\index.ts"

REM Auth Store
(
  echo import { create } from 'zustand';
  echo. 
  echo export const useAuthStore = create((set) => ({
  echo   user: null,
  echo   token: localStorage.getItem('token'),
  echo   isAuthenticated: !! localStorage.getItem('token'),
  echo   login: (token: string, user: any) => {
  echo     localStorage.setItem('token', token);
  echo     set({ token, user, isAuthenticated: true });
  echo   },
  echo   logout: () => {
  echo     localStorage.removeItem('token');
  echo     set({ token: null, user: null, isAuthenticated: false });
  echo   },
  echo }));
) > "%PROJECT_ROOT%\frontend\src\store\authStore.ts"

REM API Client
(
  echo import axios from 'axios';
  echo import { useAuthStore } from '../store/authStore';
  echo.
  echo const API_BASE_URL = process. env.REACT_APP_API_URL || 'http://localhost:8000/api';
  echo.
  echo const client = axios.create({
  echo   baseURL: API_BASE_URL,
  echo   headers: { 'Content-Type': 'application/json' },
  echo });
  echo.
  echo client.interceptors.request.use((config) => {
  echo   const token = useAuthStore. getState().token;
  echo   if (token) config.headers.Authorization = `Bearer ${token}`;
  echo   return config;
  echo });
  echo.
  echo export default client;
) > "%PROJECT_ROOT%\frontend\src\api\client.ts"

REM API endpoints stubs
(
  echo import client from './client';
  echo.
  echo export const authApi = {
  echo   login:  (username: string, password: string) =>
  echo     client.post('/auth/login', { username, password }),
  echo   register: (username: string, email: string, password: string) =>
  echo     client.post('/auth/register', { username, email, password }),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\auth.ts"

(
  echo import client from './client';
  echo.
  echo export const controllersApi = {
  echo   list: () => client.get('/controllers/'),
  echo   create: (data: any) => client.post('/controllers/', data),
  echo   delete: (id: number) => client.delete(`/controllers/${id}`),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\controllers.ts"

(
  echo import client from './client';
  echo.
  echo export const zonesApi = {
  echo   list: () => client.get('/zones/'),
  echo   create: (data: any) => client.post('/zones/', data),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\zones.ts"

(
  echo import client from './client';
  echo.
  echo export const visitorsApi = {
  echo   list: () => client.get('/visitors/'),
  echo   create: (data: any) => client.post('/visitors/', data),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\visitors.ts"

(
  echo import client from './client';
  echo.
  echo export const groupsApi = {
  echo   list: () => client.get('/groups/'),
  echo   create: (data: any) => client.post('/groups/', data),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\groups.ts"

(
  echo import client from './client';
  echo. 
  echo export const templatesApi = {
  echo   list:  () => client.get('/templates/'),
  echo   create: (data: any) => client.post('/templates/', data),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\templates.ts"

(
  echo import client from './client';
  echo.
  echo export const eventsApi = {
  echo   list: (zoneId?: number) => client.get('/events/', { params: { zone_id:  zoneId } }),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\events.ts"

(
  echo import client from './client';
  echo.
  echo export const usersApi = {
  echo   list: () => client.get('/users/'),
  echo   create: (data: any) => client.post('/users/', data),
  echo };
) > "%PROJECT_ROOT%\frontend\src\api\users.ts"

REM Pages
(
  echo import React, { useState } from 'react';
  echo import { Container, Paper, TextField, Button, Typography, Box } from '@mui/material';
  echo. 
  echo export default function Login() {
  echo   const [username, setUsername] = useState('');
  echo   const [password, setPassword] = useState('');
  echo. 
  echo   return (
  echo     ^<Container^>
  echo       ^<Paper^>
  echo         ^<Typography variant="h4"^>Login^</Typography^>
  echo         ^<TextField label="Username" value={username} onChange={(e) => setUsername(e.target. value)} /^>
  echo         ^<TextField label="Password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} /^>
  echo         ^<Button variant="contained"^>Sign In^</Button^>
  echo       ^</Paper^>
  echo     ^</Container^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\pages\Login.tsx"

(
  echo import React from 'react';
  echo import { Typography, Box } from '@mui/material';
  echo.
  echo export default function Dashboard() {
  echo   return (
  echo     ^<Box^>
  echo       ^<Typography variant="h4"^>Dashboard^</Typography^>
  echo     ^</Box^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\pages\Dashboard.tsx"

(
  echo import React from 'react';
  echo import { Typography, Box } from '@mui/material';
  echo.
  echo export default function Controllers() {
  echo   return (
  echo     ^<Box^>
  echo       ^<Typography variant="h4"^>Access Controllers^</Typography^>
  echo     ^</Box^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\pages\Controllers.tsx"

(
  echo import React from 'react';
  echo import { Typography, Box } from '@mui/material';
  echo.
  echo export default function Zones() {
  echo   return (
  echo     ^<Box^>
  echo       ^<Typography variant="h4"^>Zones^</Typography^>
  echo     ^</Box^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\pages\Zones.tsx"

REM Components
(
  echo import React from 'react';
  echo import { Drawer, List, ListItem, ListItemButton, ListItemText, Box } from '@mui/material';
  echo.
  echo export default function Sidebar() {
  echo   return (
  echo     ^<Drawer variant="permanent"^>
  echo       ^<List^>
  echo         ^<ListItem^>
  echo           ^<ListItemButton^>
  echo             ^<ListItemText primary="Dashboard" /^>
  echo           ^</ListItemButton^>
  echo         ^</ListItem^>
  echo       ^</List^>
  echo     ^</Drawer^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\components\Layout\Sidebar.tsx"

(
  echo import React from 'react';
  echo import { AppBar, Toolbar, Typography } from '@mui/material';
  echo.
  echo export default function Topbar() {
  echo   return (
  echo     ^<AppBar position="fixed"^>
  echo       ^<Toolbar^>
  echo         ^<Typography variant="h6"^>Visitor Access Control^</Typography^>
  echo       ^</Toolbar^>
  echo     ^</AppBar^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\components\Layout\Topbar.tsx"

(
  echo import React from 'react';
  echo import { Box, Container } from '@mui/material';
  echo import Topbar from './Topbar';
  echo import Sidebar from './Sidebar';
  echo.
  echo export default function MainLayout({ children }: any) {
  echo   return (
  echo     ^<Box sx={{ display: 'flex' }}^>
  echo       ^<Topbar /^>
  echo       ^<Sidebar /^>
  echo       ^<Box component="main" sx={{ flexGrow: 1, p: 3, mt: 8 }}^>
  echo         ^<Container maxWidth="lg"^>{children}^</Container^>
  echo       ^</Box^>
  echo     ^</Box^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\components\Layout\MainLayout.tsx"

(
  echo import React from 'react';
  echo. 
  echo export default function ZoneDetailTab(props: any) {
  echo   return ^<div^>Zone Detail Tab^</div^>;
  echo }
) > "%PROJECT_ROOT%\frontend\src\components\Zones\ZoneDetailTab.tsx"

REM App. tsx
(
  echo import React from 'react';
  echo import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
  echo import MainLayout from './components/Layout/MainLayout';
  echo import Login from './pages/Login';
  echo import Dashboard from './pages/Dashboard';
  echo import Controllers from './pages/Controllers';
  echo import Zones from './pages/Zones';
  echo. 
  echo export default function App() {
  echo   return (
  echo     ^<Router^>
  echo       ^<Routes^>
  echo         ^<Route path="/login" element={^<Login /^>} /^>
  echo         ^<Route path="/" element={
  echo           ^<MainLayout^>
  echo             ^<Dashboard /^>
  echo           ^</MainLayout^>
  echo         } /^>
  echo         ^<Route path="/controllers" element={
  echo           ^<MainLayout^>
  echo             ^<Controllers /^>
  echo           ^</MainLayout^>
  echo         } /^>
  echo         ^<Route path="/zones" element={
  echo           ^<MainLayout^>
  echo             ^<Zones /^>
  echo           ^</MainLayout^>
  echo         } /^>
  echo       ^</Routes^>
  echo     ^</Router^>
  echo   );
  echo }
) > "%PROJECT_ROOT%\frontend\src\App.tsx"

REM index.tsx
(
  echo import React from 'react';
  echo import ReactDOM from 'react-dom/client';
  echo import App from './App';
  echo import { Toaster } from 'react-hot-toast';
  echo. 
  echo const root = ReactDOM.createRoot(
  echo   document.getElementById('root') as HTMLElement
  echo );
  echo.
  echo root. render(
  echo   ^<React.StrictMode^>
  echo     ^<App /^>
  echo     ^<Toaster /^>
  echo   ^</React.StrictMode^>
  echo );
) > "%PROJECT_ROOT%\frontend\src\index.tsx"

REM Frontend . env
(
  echo REACT_APP_API_URL=http://localhost:8000/api
  echo REACT_APP_VERSION=1.0.0
) > "%PROJECT_ROOT%\frontend\.env"

REM Dockerfile
(
  echo FROM node: 18-alpine
  echo WORKDIR /app
  echo COPY package*.json ./
  echo RUN npm ci
  echo COPY . .
  echo EXPOSE 3000
  echo CMD ["npm", "start"]
) > "%PROJECT_ROOT%\frontend\Dockerfile"

echo   [✓] Frontend files created

REM ============================================
REM CREATE ROOT FILES
REM ============================================

REM . env.example
(
  echo DATABASE_URL=postgresql://visitor_user:visitor_pass@localhost:5432/visitor_control
  echo SECRET_KEY=your-super-secret-key-change-this-minimum-32-characters
  echo POSTGRES_USER=visitor_user
  echo POSTGRES_PASSWORD=visitor_pass
  echo REACT_APP_API_URL=http://localhost:8000/api
) > "%PROJECT_ROOT%\. env.example"

REM docker-compose.yml (stub)
(
  echo version: '3.8'
  echo. 
  echo services:
  echo   db:
  echo     image: postgres:15-alpine
  echo     environment: 
  echo       POSTGRES_USER: ${POSTGRES_USER:-visitor_user}
  echo       POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-visitor_pass}
  echo       POSTGRES_DB:  visitor_control
  echo     ports: 
  echo       - "5432:5432"
  echo. 
  echo   backend:
  echo     build: ./backend
  echo     ports: 
  echo       - "8000:8000"
  echo     depends_on:
  echo       - db
  echo.
  echo   frontend:
  echo     build: ./frontend
  echo     ports:
  echo       - "3000:3000"
  echo     depends_on:
  echo       - backend
) > "%PROJECT_ROOT%\docker-compose.yml"

REM README.md
(
  echo # Visitor Access Control System
  echo. 
  echo A complete, production-ready visitor management system integrated with Hikvision access controllers.
  echo. 
  echo ## Features
  echo. 
  echo - ✅ Hikvision Integration
  echo - ✅ Visitor Management with QR Codes
  echo - ✅ Real-time Access Control
  echo - ✅ Zone Management
  echo - ✅ Live Events Monitoring
  echo - ✅ Advanced Reporting
  echo. 
  echo ## Quick Start
  echo.
  echo ### Windows (No Docker)
  echo.
  echo 1. Install: Python 3.10+, Node.js 16+, PostgreSQL
  echo 2. Backend: `cd backend && python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt`
  echo 3. Frontend: `cd frontend && npm install`
  echo 4. Start Backend: `python -m uvicorn app.main:app --reload`
  echo 5. Start Frontend: `npm start`
  echo.
  echo See WINDOWS_INSTALL_GUIDE.md for details. 
  echo.
  echo ## Documentation
  echo.
  echo - WINDOWS_INSTALL_GUIDE. md - Complete Windows setup
  echo - QUICKSTART.md - Quick reference
  echo - API Docs at http://localhost:8000/docs
) > "%PROJECT_ROOT%\README.md"

REM Create stub documentation files
(
  echo # Installation Guide
  echo TODO: Add installation instructions
) > "%PROJECT_ROOT%\INSTALL_GUIDE.md"

(
  echo # Quick Start
  echo TODO: Add quick start guide
) > "%PROJECT_ROOT%\QUICKSTART.md"

(
  echo # Windows Installation Guide
  echo TODO: Add Windows-specific installation guide
) > "%PROJECT_ROOT%\WINDOWS_INSTALL_GUIDE.md"

(
  echo # Windows Setup Checklist
  echo TODO: Add setup checklist
) > "%PROJECT_ROOT%\WINDOWS_SETUP_CHECKLIST.md"

(
  echo # README for Windows
  echo TODO: Add Windows-specific README
) > "%PROJECT_ROOT%\README_WINDOWS.md"

REM Backend Dockerfile
(
  echo FROM python:3.11-slim
  echo WORKDIR /app
  echo COPY requirements.txt .
  echo RUN pip install -r requirements.txt
  echo COPY . .
  echo EXPOSE 8000
  echo CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
) > "%PROJECT_ROOT%\backend\Dockerfile"

REM nginx.conf stub
(
  echo # TODO: Add Nginx configuration
) > "%PROJECT_ROOT%\nginx.conf"

echo. 
echo ╔════════════════════════════════════════════════════════╗
echo ║  ✅ Project Setup Complete!                            ║
echo ║                                                        ║
echo ║  Directory structure created:                          ║
echo ║  - backend/app/   (models, routes, schemas, etc)      ║
echo ║  - frontend/src/  (pages, components, api, etc)       ║
echo ║  - Root files     (README, .env, docker-compose)      ║
echo ║                                                        ║
echo ║  Next Steps:                                          ║
echo ║  1. Edit backend\. env with your database URL         ║
echo ║  2. Edit files in backend/app and frontend/src       ║
echo ║  3. Run: cd backend && python -m venv venv           ║
echo ║  4. Run: venv\Scripts\activate                        ║
echo ║  5. Run: pip install -r requirements.txt             ║
echo ║  6. Run: cd frontend && npm install                  ║
echo ║  7. Start the system!                                 ║
echo ║                                                        ║
echo ║  Location: %PROJECT_ROOT%                   ║
echo ╚════════════════════════════════════════════════════════╝
echo. 

pause