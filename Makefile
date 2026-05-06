.PHONY: dev test build clean up down logs

# Environment (default: local)
ENV ?= local
ENV_FILE := .env.$(ENV)

# Development - runs both services locally (no Docker)
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
	docker compose --env-file $(ENV_FILE) build

# Start all services with Docker Compose
up:
	@echo "Starting services with $(ENV_FILE)..."
	docker compose --env-file $(ENV_FILE) up -d

# Stop all services
down:
	docker compose --env-file $(ENV_FILE) down

# View logs
logs:
	docker compose --env-file $(ENV_FILE) logs -f

# Clean build artifacts
clean:
	cd backend && ./mvnw clean
	cd frontend && rm -rf .next node_modules

# Shortcuts for environments
up-local:
	$(MAKE) up ENV=local

up-prod:
	$(MAKE) up ENV=prod

build-local:
	$(MAKE) build ENV=local

build-prod:
	$(MAKE) build ENV=prod

down-local:
	$(MAKE) down ENV=local

down-prod:
	$(MAKE) down ENV=prod

logs-local:
	$(MAKE) logs ENV=local

logs-prod:
	$(MAKE) logs ENV=prod
