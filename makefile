# n8n Project Template - Makefile

# Git hooks and workflow management
pre-commit:
	lefthook run pre-commit --force

export-workflows:
	./scripts/export-workflows.sh

# Docker Compose commands
up:
	docker compose up -d --scale n8n-worker=2

down:
	docker compose down

reload:
	docker compose down && docker compose up --build -d --scale n8n-worker=2

# Scaling commands
scale-workers:
	docker compose up -d --scale n8n-worker=$(WORKERS)

scale-up:
	docker compose up -d --scale n8n-worker=4

scale-down:
	docker compose up -d --scale n8n-worker=1

status:
	docker compose ps

logs:
	docker compose logs -f

logs-n8n:
	docker compose logs -f n8n

logs-postgres:
	docker compose logs -f postgres

clean:
	docker compose down -v
	docker system prune -f

help:
	@echo "Available commands:"
	@echo "  up              - Start all services with 2 workers"
	@echo "  down            - Stop all services"
	@echo "  reload          - Rebuild and restart all services"
	@echo "  scale-up        - Scale to 4 workers"
	@echo "  scale-down      - Scale to 1 worker"
	@echo "  status          - Show service status"
	@echo "  logs            - Show all service logs"
	@echo "  logs-n8n        - Show only n8n logs"
	@echo "  logs-postgres   - Show only postgres logs"
	@echo "  clean           - Stop services and remove volumes"
	@echo "  pre-commit      - Run git pre-commit hooks"
	@echo "  export-workflows - Export n8n workflows manually"

.PHONY: pre-commit export-workflows up down reload scale-workers scale-up scale-down status logs logs-n8n logs-postgres clean help