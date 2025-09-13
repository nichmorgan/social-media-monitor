# Social Media Monitor

Sistema de monitoramento de redes sociais com análise de intenções usando n8n, PostgreSQL e IA para rastrear e analisar posts sobre temas específicos.

## 🎯 Funcionalidades

- 🔍 **Monitoramento Multi-Plataforma** - Twitter, Instagram, LinkedIn
- 🧠 **Análise de Sentimento** - OpenAI, Groq, Anthropic Claude
- 🎭 **Análise de Intenção** - Categorização automática de posts
- 📊 **Dashboard Analytics** - Métricas e relatórios em tempo real
- 🚨 **Sistema de Alertas** - Notificações via Slack/Discord/Email
- 💾 **Armazenamento Estruturado** - PostgreSQL com schema otimizado
- 🔄 **Processamento em Batch** - Redis queue para escalabilidade

## 🚀 Quick Start

1. **Clone este projeto**
   ```bash
   git clone https://github.com/nichmorgan/social-media-monitor.git
   cd social-media-monitor
   ```

2. **Configure o ambiente**
   ```bash
   cp .env.example .env
   # Edite .env com suas API keys e configurações
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

## 🏗️ Arquitetura

### Componentes Principais

- **n8n Workflows** - Engine de automação e orquestração
- **PostgreSQL** - Armazenamento de posts, análises e métricas
- **Redis** - Queue system para processamento assíncrono
- **AI Services** - OpenAI, Groq, Anthropic para análise de texto
- **Social APIs** - Twitter, Instagram, LinkedIn integration
- **Notifications** - Slack, Discord, Email para alertas

### Fluxo de Dados

```
[Social Media APIs] → [n8n Ingestion] → [AI Analysis] → [PostgreSQL] → [Alerts/Reports]
                                          ↓
                                    [Redis Queue]
                                          ↓
                                    [n8n Workers]
```

## 🔧 Configuration

### Configuração de API Keys

**APIs de Redes Sociais:**
```bash
# Twitter API v2
TWITTER_API_KEY=your_twitter_api_key_here
TWITTER_API_SECRET=your_twitter_api_secret_here
TWITTER_ACCESS_TOKEN=your_twitter_access_token_here
TWITTER_ACCESS_TOKEN_SECRET=your_twitter_access_token_secret_here

# Instagram Graph API
INSTAGRAM_ACCESS_TOKEN=your_instagram_access_token_here

# LinkedIn API
LINKEDIN_CLIENT_ID=your_linkedin_client_id_here
LINKEDIN_CLIENT_SECRET=your_linkedin_client_secret_here
```

**Serviços de IA:**
```bash
OPENAI_API_KEY=your_openai_api_key_here
GROQ_API_KEY=your_groq_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here
```

**Configuração de Monitoramento:**
```bash
MONITORING_KEYWORDS=sustainability,green energy,climate change
MONITORING_HASHTAGS=#sustainability,#climatechange,#greenenergy
SENTIMENT_THRESHOLD=0.5
CONFIDENCE_THRESHOLD=0.7
```

### Nodes Especializados

O projeto inclui nodes específicos para análise de redes sociais:

```json
{
  "dependencies": {
    "@n8n/n8n-nodes-langchain": "*",
    "n8n-nodes-twitter": "*",
    "n8n-nodes-sentiment": "*",
    "n8n-nodes-database": "*"
  }
}
```

### Temas de Monitoramento

Configuração em `n8n/knowledge/social-media-topics.json`:

- **Sustentabilidade** - Keywords e hashtags relacionadas
- **Mudanças Climáticas** - Monitoramento de discussões ambientais
- **Energia Renovável** - Tendências em energia limpa
- **ESG** - Governança corporativa e responsabilidade social

## 🐳 Services

| Service | Port | Description |
|---------|------|-------------|
| n8n | 5678 | Main n8n interface |
| PostgreSQL | 5432 | Database |
| Redis | 6379 | Queue system |
| Adminer | 8080 | Database admin |

## 📁 Project Structure

```
social-media-monitor/
├── .docker/              # Scripts de inicialização do banco
├── n8n/
│   ├── credentials/      # Templates de credenciais das APIs
│   │   └── social-media-apis.json
│   ├── flows/           # Workflows de monitoramento (auto-export)
│   ├── knowledge/       # Base de conhecimento
│   │   ├── social-media-topics.json    # Temas e keywords
│   │   └── database-schema.sql          # Schema do banco
│   └── nodes/           # Nodes especializados
├── docker-compose.yml   # Configuração dos serviços
├── .env.example        # Template com todas as variáveis
└── README.md           # Esta documentação
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

## 🔄 Workflows de Monitoramento

O sistema inclui workflows pré-configurados para:

### 1. **Data Ingestion Workflows**
- Coleta de posts do Twitter por keywords/hashtags
- Monitoramento de contas Instagram específicas
- Captura de posts LinkedIn de empresas

### 2. **Analysis Workflows**
- Análise de sentimento com múltiplas APIs de IA
- Categorização de intenção dos posts
- Cálculo de scores de relevância

### 3. **Storage & Processing**
- Armazenamento estruturado no PostgreSQL
- Detecção de duplicatas
- Processamento de mídia anexada

### 4. **Alerting Workflows**
- Alertas por sentiment threshold
- Notificação de posts virais
- Relatórios diários/semanais

### Export Automático

```bash
make pre-commit  # Exporta workflows manualmente
```

## 📊 Base de Dados

### Schema Principal

O sistema utiliza as seguintes tabelas:

- **`social_posts`** - Posts coletados das redes sociais
- **`sentiment_analysis`** - Resultados da análise de sentimento
- **`intent_analysis`** - Categorização de intenções
- **`monitoring_topics`** - Temas e keywords monitorados
- **`post_topics`** - Relacionamento posts ↔ temas
- **`alerts`** - Sistema de alertas
- **`daily_analytics`** - Métricas agregadas

### Métricas Disponíveis

- Volume de posts por tema/período
- Distribuição de sentimentos
- Trends de engajamento
- Top influenciadores por tema
- Alertas de sentiment negativo

### Acesso aos Dados

- **Adminer**: http://localhost:8080 (interface web)
- **Direct SQL**: Via workflows n8n
- **API**: Endpoints customizados via n8n webhooks

## 🔐 Configuração de APIs

### Twitter API v2
1. Crie uma conta de desenvolvedor em [developer.twitter.com](https://developer.twitter.com)
2. Crie um app e gere as API keys
3. Configure os escopos: `tweet.read`, `users.read`, `follows.read`

### Instagram Graph API
1. Crie uma conta de desenvolvedor no Facebook
2. Configure acesso ao Instagram Graph API
3. Gere um token de longa duração
4. **Nota**: Funciona apenas com contas Instagram Business

### LinkedIn API
1. Crie uma aplicação LinkedIn Developer
2. Solicite acesso ao LinkedIn Marketing API
3. Configure OAuth2 flow

### Serviços de IA
- **OpenAI**: API key em [platform.openai.com](https://platform.openai.com)
- **Groq**: API key em [console.groq.com](https://console.groq.com)
- **Anthropic**: API key em [console.anthropic.com](https://console.anthropic.com)

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

## 📈 Exemplos de Uso

### Monitoramento de Marca
- Track menções da sua empresa
- Análise de sentiment de campanhas
- Identificação de crises de reputação

### Pesquisa de Mercado
- Tendências em sustentabilidade
- Opinião pública sobre ESG
- Análise de competidores

### Compliance e Regulamentação
- Monitoramento de discussões regulatórias
- Tracking de políticas ambientais
- Análise de impacto de novas leis

---

**🌱 Construído para monitorar o futuro sustentável**