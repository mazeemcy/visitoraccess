. PHONY: help install build up down logs restart clean

help:
	@echo "Visitor Access Control System - Available Commands:"
	@echo ""
	@echo "  make install      - Install dependencies (backend & frontend)"
	@echo "  make build        - Build Docker images"
	@echo "  make up           - Start all services with Docker Compose"
	@echo "  make down         - Stop all services"
	@echo "  make logs         - View service logs"
	@echo "  make restart      - Restart all services"
	@echo "  make clean        - Remove containers and volumes"
	@echo "  make db-reset     - Reset database"
	@echo "  make migrations   - Run database migrations"
	@echo ""

install:
	@echo "Installing dependencies..."
	cd backend && pip install -r requirements.txt
	cd frontend && npm install

build: 
	docker-compose build

up:
	docker-compose up -d
	@echo "✅ Services started.  Access at http://localhost:3000"

down:
	docker-compose down

logs:
	docker-compose logs -f

restart:
	docker-compose restart

clean:
	docker-compose down -v
	@echo "✅ Containers and volumes removed"

db-reset:
	docker-compose exec db psql -U visitor_user -d visitor_control -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
	@echo "✅ Database reset"

migrations:
	@echo "Running migrations..."
	docker-compose exec backend python -m alembic upgrade head

dev-backend:
	cd backend && source venv/bin/activate && uvicorn app.main:app --reload

dev-frontend:
	cd frontend && npm start
