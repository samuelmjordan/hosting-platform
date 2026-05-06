.PHONY: dev test build clean

# Development - runs both services locally
dev:
	@echo "Starting development servers..."
	$(MAKE) -j2 dev-backend dev-frontend

dev-backend:
	cd backend && ./mvnw spring-boot:run

dev-frontend:
	cd frontend && npm run dev

# Run tests for both services
test:
	@echo "Running backend tests..."
	cd backend && ./mvnw test
	@echo "Running frontend tests..."
	cd frontend && npm run lint

# Build Docker images
build:
	docker compose build

# Start all services with Docker Compose
up:
	docker compose up -d

# Stop all services
down:
	docker compose down

# View logs
logs:
	docker compose logs -f

# Clean build artifacts
clean:
	cd backend && ./mvnw clean
	cd frontend && rm -rf .next node_modules
