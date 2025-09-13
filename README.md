# n8n Project Template

A production-ready template for n8n automation projects with PostgreSQL, Redis, and Docker support.

## 🚀 Quick Start

1. **Clone this template**
   ```bash
   git clone <your-repo-url>
   cd n8n-project-template
   ```

2. **Setup environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Install git hooks**
   ```bash
   lefthook install
   ```

4. **Start services**
   ```bash
   make up
   ```

5. **Access n8n**
   - Open http://localhost:5678
   - Login with credentials from `.env` file

## 📋 Features

- **n8n Automation Platform** - Main workflow engine
- **PostgreSQL Database** - Persistent data storage
- **Redis Queue** - Background job processing
- **Adminer** - Database administration interface
- **Worker Scaling** - Multiple n8n workers for performance
- **Git Hooks** - Automatic workflow export on commits
- **Docker Compose** - Complete containerized setup

## 🔧 Configuration

### Environment Variables

Create `.env` file from `.env.example`:

```bash
# n8n Configuration
N8N_DB_USER=n8n
N8N_DB_PASSWORD=n8n
N8N_DB_NAME=n8n
N8N_USER=n8n@admin.com
N8N_PASSWORD=n8n
N8N_LOG_LEVEL=debug

# API Keys
GROQ_API_KEY=your_groq_api_key_here
GOOGLE_API_KEY=your_google_api_key_here
OPENAI_API_KEY=your_openai_api_key_here
```

### Community Nodes

Add community packages to `n8n/nodes/package.json`:

```json
{
  "dependencies": {
    "@n8n/n8n-nodes-langchain": "*",
    "n8n-nodes-ai": "*"
  }
}
```

## 🐳 Services

| Service | Port | Description |
|---------|------|-------------|
| n8n | 5678 | Main n8n interface |
| PostgreSQL | 5432 | Database |
| Redis | 6379 | Queue system |
| Adminer | 8080 | Database admin |

## 📁 Project Structure

```
n8n-project-template/
├── .docker/              # Database initialization scripts
├── .claude/              # Claude Code configuration
├── .vscode/              # VS Code settings
├── n8n/
│   ├── credentials/      # n8n credential exports
│   ├── data/            # Static data files
│   ├── flows/           # Workflow exports (auto-generated)
│   ├── knowledge/       # Knowledge base files
│   └── nodes/           # Community node packages
├── docker-compose.yml   # Service definitions
├── n8n.dockerfile      # n8n container configuration
├── lefthook.yml        # Git hooks configuration
├── makefile            # Development commands
└── .env.example        # Environment template
```

## 🛠️ Development Commands

```bash
# Start services
make up

# Stop services
make down

# Rebuild and restart
make reload

# Scale workers
make scale-up      # 4 workers
make scale-down    # 1 worker

# View logs
make logs          # All services
make logs-n8n      # n8n only
make logs-postgres # PostgreSQL only

# Service status
make status

# Clean everything
make clean

# Help
make help
```

## 🔄 Workflow Management

This template includes automatic workflow export via git hooks:

1. **Automatic Export**: Workflows are exported when you commit
2. **Version Control**: All workflows are tracked in git
3. **Team Collaboration**: Share workflows through git

### Manual Export

```bash
make pre-commit
```

## 📚 Knowledge Base

Store static data files in `n8n/knowledge/`:

```
n8n/knowledge/
├── data/
│   ├── products.csv
│   └── customers.json
└── templates/
    └── email_template.html
```

Access in workflows using `/knowledge/` path.

## 🔐 Security Best Practices

1. **Environment Variables**: Store sensitive data in `.env`
2. **Git Ignore**: Never commit actual credentials
3. **Credential Templates**: Export credential structures only
4. **Database Access**: Use strong passwords in production

## 🔧 Customization

### Adding Services

Extend `docker-compose.yml` with additional services:

```yaml
services:
  your-service:
    image: your-image
    ports:
      - "8000:8000"
    depends_on:
      - postgres
```

### Custom Scripts

Add custom scripts to handle project-specific requirements.

## 📖 Documentation

- [n8n Documentation](https://docs.n8n.io/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

[Add your license here]

## 🆘 Support

For issues and questions:
1. Check the documentation
2. Search existing issues
3. Create a new issue with details

---

**Built with ❤️ for automation enthusiasts**