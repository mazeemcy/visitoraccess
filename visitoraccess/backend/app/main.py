# Visitor Access Control - FastAPI Backend
# Entry point

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
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


@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
