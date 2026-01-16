# Visitor Access Control - FastAPI Backend
# Entry point

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from pathlib import Path
from starlette.staticfiles import StaticFiles
from starlette.responses import FileResponse
from app.routes import (
    auth,
    controllers,
    gates,
    zones,
    visitors,
    groups,
    events,
    users,
    roles,
    templates,
)
from app.db.database import engine, Base
from fastapi.staticfiles import StaticFiles
import pathlib

# Create tables
Base.metadata.create_all(bind=engine)


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("System Started")
    yield
    print("System Shutting Down")


app = FastAPI(title="Visitor Access Control API", lifespan=lifespan)

# CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Serve frontend static files if built
BASE_DIR = pathlib.Path(__file__).resolve().parents[2]
frontend_dist = BASE_DIR / "frontend" / "dist"

if frontend_dist.exists():
    app.mount("/", StaticFiles(directory=str(frontend_dist), html=True), name="frontend")
else:
    @app.get("/")
    async def root():
        return {"message": "Frontend not built. Visit /health or /api/"}

# Routes
app.include_router(auth.router, prefix="/api/auth", tags=["auth"])
app.include_router(controllers.router, prefix="/api/controllers", tags=["controllers"])
app.include_router(gates.router, prefix="/api/gates", tags=["gates"])
app.include_router(zones.router, prefix="/api/zones", tags=["zones"])
app.include_router(visitors.router, prefix="/api/visitors", tags=["visitors"])
app.include_router(groups.router, prefix="/api/groups", tags=["groups"])
app.include_router(events.router, prefix="/api/events", tags=["events"])
app.include_router(users.router, prefix="/api/users", tags=["users"])
app.include_router(roles.router, prefix="/api/roles", tags=["roles"])
app.include_router(templates.router, prefix="/api/templates", tags=["templates"])

# Serve frontend static files when a production build exists (frontend/dist)
# - Mount static assets under /static
# - Serve index.html at / and as a fallback for non-/api routes (SPA client-side routing)

dist_dir = Path(__file__).resolve().parents[2] / "frontend" / "dist"
index_file = dist_dir / "index.html"

if dist_dir.exists():
    # Serve static assets. Use /static to avoid interfering with /api paths.
    app.mount("/static", StaticFiles(directory=str(dist_dir)), name="static")

    if index_file.exists():
        @app.get("/", include_in_schema=False)
        async def root():
            return FileResponse(index_file)

        @app.get("/{full_path:path}", include_in_schema=False)
        async def spa_fallback(full_path: str):
            # Let API routes (starting with 'api') be handled by API routers
            if full_path.startswith("api"):
                from fastapi import HTTPException
                raise HTTPException(status_code=404)
            return FileResponse(index_file)


@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
