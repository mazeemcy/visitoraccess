# 🔐 Visitor Access Control System - Installation Guide

**Last Updated:** 2026-01-15  
**Project Owner:** @mazeemcy

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Backend Setup](#backend-setup)
3. [Frontend Setup](#frontend-setup)
4. [Docker Setup (Recommended)](#docker-setup-recommended)
5. [Configuration](#configuration)
6. [Running the Application](#running-the-application)
7. [Accessing the Application](#accessing-the-application)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### System Requirements
- **OS:** Linux, macOS, or Windows
- **Python:** 3.10 or higher
- **Node.js:** v16+ (for frontend)
- **npm/yarn:** Latest stable
- **PostgreSQL:** 12+ (or use Docker)
- **Docker & Docker Compose** (optional but recommended)
- **Git:** For cloning repository

### Installation Verification

```bash
# Check Python
python --version  # Should be 3.10+

# Check Node.js
node --version    # Should be v16+
npm --version

# Check Git
git --version

# Check PostgreSQL (if installing locally)
psql --version