#!/bin/bash

# Start Visitor Access Control System (Development Mode)
# Usage: ./scripts/start-dev. sh

set -e

echo "🚀 Starting Visitor Access Control System (Development)"
echo "=================================================="

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed. Please install Docker Compose first.${NC}"
    exit 1
fi

# Check if . env file exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Creating from example...${NC}"
    cp . env.example .env
    echo -e "${GREEN}✅ .env file created.  Please update with your settings.${NC}"
fi

# Start services
echo -e "${YELLOW}📦 Starting services...${NC}"
docker-compose up -d

# Wait for services to be ready
echo -e "${YELLOW}⏳ Waiting for services to start...${NC}"
sleep 10

# Check service health
echo -e "${YELLOW}🔍 Checking service health... ${NC}"

if docker-compose exec -T db pg_isready -U visitor_user &> /dev/null; then
    echo -e "${GREEN}✅ Database is ready${NC}"
else
    echo -e "${RED}❌ Database is not ready${NC}"
fi

if curl -f http://localhost:8000/health &> /dev/null; then
    echo -e "${GREEN}✅ Backend API is ready${NC}"
else
    echo -e "${RED}⚠️  Backend API is not ready yet.  Wait a few more seconds.${NC}"
fi

if curl -f http://localhost:3000 &> /dev/null; then
    echo -e "${GREEN}✅ Frontend is ready${NC}"
else
    echo -e "${RED}⚠️  Frontend is not ready yet.  Wait a few more seconds.${NC}"
fi

echo ""
echo -e "${GREEN}=================================================="
echo "✅ Visitor Access Control System is running!"
echo "=================================================="
echo ""
echo -e "📱 Frontend:   ${GREEN}http://localhost:3000${NC}"
echo -e "🔌 API:       ${GREEN}http://localhost:8000${NC}"
echo -e "📚 API Docs:  ${GREEN}http://localhost:8000/docs${NC}"
echo -e "🐘 Database:  ${GREEN}localhost:5432${NC}"
echo ""
echo "Default Login:"
echo "  Username: admin"
echo "  Password: (set during first signup)"
echo ""
echo "View logs:  docker-compose logs -f"
echo "Stop services: docker-compose down"
echo ""