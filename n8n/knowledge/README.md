# Knowledge Base

This directory is for storing knowledge base files that your n8n workflows can access.

## Structure

- Place your data files (CSV, JSON, TXT, etc.) in subdirectories
- Files are read-only mounted in the n8n container at `/knowledge`
- Use n8n's File System nodes to read these files in your workflows

## Examples

```
knowledge/
├── data/
│   ├── products.csv
│   └── customers.json
├── templates/
│   └── email_template.html
└── configs/
    └── api_endpoints.json
```

## Access in n8n

In your workflows, reference files using the `/knowledge` path:
- `/knowledge/data/products.csv`
- `/knowledge/templates/email_template.html`