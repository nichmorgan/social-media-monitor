# n8n Workflows

This directory contains exported n8n workflow definitions that are automatically managed by git hooks.

## Automatic Export

- Workflows are automatically exported from n8n when you commit changes
- The `lefthook` git hook handles this process
- All workflows from your n8n instance will be saved here as JSON files

## Setup

1. Install git hooks: `lefthook install`
2. Make changes in your n8n workflows
3. Commit your changes - workflows will be automatically exported

## Manual Export

To manually export workflows, run:
```bash
make pre-commit
```

## Structure

Each workflow is saved as `{workflow-name}_{workflow-id}.json`

Example:
```
flows/
├── Data Processing Workflow_1.json
├── Email Automation_2.json
└── API Integration_3.json
```