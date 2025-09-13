#!/bin/bash

# n8n Workflows Export Script
# This script exports all workflows from n8n to the flows directory

set -euo pipefail

# Configuration
CONTAINER_NAME="n8n-project-template-n8n-1"
FLOWS_DIR="./n8n/flows"
BACKUP_DIR="./n8n/flows/backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if docker is available
if ! command -v docker &> /dev/null; then
    log_error "Docker is not installed or not in PATH"
    exit 1
fi

# Check if n8n container is running
if ! docker ps --format "table {{.Names}}" | grep -q "n8n"; then
    log_error "n8n container is not running. Please start it with 'make up' or 'docker compose up'"
    exit 1
fi

# Find the actual n8n container name
ACTUAL_CONTAINER=$(docker ps --format "{{.Names}}" | grep "n8n" | grep -v "worker" | head -1)
if [ -z "$ACTUAL_CONTAINER" ]; then
    log_error "Could not find running n8n container"
    exit 1
fi

log_info "Found n8n container: $ACTUAL_CONTAINER"

# Create flows directory if it doesn't exist
mkdir -p "$FLOWS_DIR"

# Create backup directory and backup existing workflows
if [ "$(ls -A $FLOWS_DIR 2>/dev/null)" ]; then
    log_info "Creating backup of existing workflows..."
    mkdir -p "$BACKUP_DIR"
    cp "$FLOWS_DIR"/*.json "$BACKUP_DIR/" 2>/dev/null || true
    rm -f "$FLOWS_DIR"/*.json 2>/dev/null || true
fi

log_info "🚀 Exporting workflows from n8n..."

# Export workflows from n8n container
if docker exec "$ACTUAL_CONTAINER" n8n export:workflow --backup --output=/flows/; then
    # Count exported workflows
    WORKFLOW_COUNT=$(ls -1 "$FLOWS_DIR"/*.json 2>/dev/null | wc -l || echo "0")

    if [ "$WORKFLOW_COUNT" -gt 0 ]; then
        log_success "✅ Workflows exported successfully! ($WORKFLOW_COUNT workflows)"

        # List exported workflows
        log_info "Exported workflows:"
        ls -1 "$FLOWS_DIR"/*.json 2>/dev/null | sed 's|.*/||' | sed 's|^|  - |'

        # Add to git staging if in a git repository
        if [ -d ".git" ]; then
            log_info "📝 Adding exported workflows to git staging area..."
            git add "$FLOWS_DIR"/*.json 2>/dev/null || true
        fi
    else
        log_warning "⚠️  No workflows found to export"
    fi
else
    log_error "❌ Failed to export workflows from n8n"
    exit 1
fi

log_success "🎉 Workflow export completed!"