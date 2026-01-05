# 🏠 H.O.M.E.S - Heuristic Operative Modular Engineering System

<div align="center">

![HOMES Logo](assets/imagem_casa.jpg)

**Sistema modular de automação completa para criação de vídeos faceless via IA + Voz**

[![Hackatime 2026](https://img.shields.io/badge/Hackatime-2026-ff6b6b?style=for-the-badge)](https://hackatime.hackclub.com/)
[![Status](https://img.shields.io/badge/Status-Active_Development-00ff9d?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)]()

</div>

---

## 🎯 Visão Geral

HOMES é um **ecossistema de 4 repositórios interconectados** que formam uma pipeline completa de produção de vídeos automatizada:

```
🎤 Voice Input → 🧠 AI Processing → 🎬 Video Rendering → 📱 Mobile Delivery
```

### 📦 Ecossistema

| Repositório | Tecnologia | Função |
|-------------|-----------|--------|
| **[HOMES](https://github.com/EngThi/HOMES)** | Markdown/Scripts | Hub central + Documentação |
| **[HOMES-Engine](https://github.com/EngThi/HOMES-Engine)** | Python + FFmpeg | Renderização mobile (Termux) |
| **[homes-prompt-manager](https://github.com/EngThi/homes-prompt-manager)** | React + Vite | Interface web + Voice Control |
| **[ai-video-factory](https://github.com/EngThi/ai-video-factory)** | NestJS + TypeScript | Backend + AI orchestration |

---

## ✨ Features Principais

- 🎤 **Voice-to-Video**: Fale um comando e receba vídeo pronto em 2 minutos
- 🧠 **AI Contextual**: Sistema aprende suas preferências e mantém consistência de marca
- 📱 **Mobile First**: Renderização rodando 100% no celular via Termux
- 🔄 **Real-time Feedback**: WebSocket mostra progresso ao vivo
- 🎨 **Multi-style**: Temas visuais (Cinematic, Documentary, Vlog)
- 🌐 **Zero-cost**: Baseado em APIs gratuitas (Gemini, Edge-TTS)

---

## 🚀 Quick Start

### Pré-requisitos

```bash
# Ferramentas necessárias
- Node.js 18+
- Python 3.8+
- Git
- FFmpeg (para HOMES-Engine)
- Termux (Android, opcional)
```

### Instalação Completa

```bash
# 1. Clonar este repositório (hub)
git clone https://github.com/EngThi/HOMES.git
cd HOMES

# 2. Rodar script de setup (clona e instala tudo)
bash scripts/setup-all.sh

# 3. Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas API keys

# 4. Iniciar ecossistema
bash scripts/start-ecosystem.sh
```

### Instalação Manual (Por Repositório)

#### Backend (ai-video-factory)
```bash
git clone https://github.com/EngThi/ai-video-factory.git
cd ai-video-factory
npm install
npm run start
# Rodando em http://localhost:3000
```

#### Frontend (homes-prompt-manager)
```bash
git clone https://github.com/EngThi/homes-prompt-manager.git
cd homes-prompt-manager
npm install
npm run dev
# Rodando em http://localhost:5173
```

#### Mobile Worker (HOMES-Engine)
```bash
git clone https://github.com/EngThi/HOMES-Engine.git
cd HOMES-Engine
pip install -r requirements.txt
python3 integration/queue_poller.py
# Aguardando projetos... 
```

---

## 📊 Arquitetura

### Fluxo de Dados

```
┌─────────────────────────────────────────────────────────┐
│  1. homes-prompt-manager (React Frontend)               │
│     - Usuário fala:  "Faça um vídeo sobre Estoicismo"   │
│     - Web Speech API captura voz                        │
│     - Socket.IO conecta ao backend                      │
└────────────────┬────────────────────────────────────────┘
                 │ HTTP POST /api/project/create
                 ↓
┌─────────────────────────────────────────────────────────┐
│  2. ai-video-factory (NestJS Backend)                   │
│     - Carrega BrandProfile do Firebase                  │
│     - Gemini 2.5 Flash gera roteiro contextualizado    │
│     - Gera 5 imagens em paralelo (TURBO MODE)          │
│     - Salva projeto como PENDING no Firestore          │
│     - WebSocket notifica frontend do progresso         │
└────────────────┬────────────────────────────────────────┘
                 │ Firestore (status: PENDING)
                 ↓
┌─────────────────────────────────────────────────────────┐
│  3. HOMES-Engine (Python Worker - Termux)              │
│     - Polling GET /api/project/pending (a cada 10s)    │
│     - Detecta novo projeto                             │
│     - Edge-TTS gera narração (pt-BR-AntonioNeural)     │
│     - FFmpeg compõe vídeo 720x1280 (9:16)              │
│     - Ken Burns effect + Music ducking                 │
│     - POST /api/project/:id/complete                   │
└────────────────┬────────────────────────────────────────┘
                 │
                 ↓
┌─────────────────────────────────────────────────────────┐
│  4. Entrega Final                                       │
│     - Notificação Android (termux-notification)        │
│     - Vídeo salvo em /sdcard/Download                  │
│     - Frontend mostra "✅ Vídeo Pronto!"               │
│     - BrandProfile atualizado com novo tópico          │
└─────────────────────────────────────────────────────────┘
```

### Tecnologias

**Frontend**
- React 19 + TypeScript
- Vite (dev server)
- Socket.IO Client
- Web Speech API

**Backend**
- NestJS + Express
- Firebase Firestore
- Google Gemini 2.5 Flash
- WebSocket (Socket.IO)

**Mobile Worker**
- Python 3.8+
- Edge-TTS (narração)
- FFmpeg (vídeo)
- Termux API (Android)

**Infraestrutura**
- Firebase (Firestore + Storage)
- GitHub (repos + CI/CD)
- Docker (opcional)

---

## 📚 Documentação

### Guias Principais

- **[Arquitetura Completa](docs/architecture.md)** - Entenda como tudo se conecta
- **[Setup Guide](docs/setup-guide.md)** - Instalação passo a passo
- **[Integration Flow](docs/integration-flow.md)** - Fluxo de dados detalhado
- **[Strategy](docs/strategy.md)** - Roadmap Hackatime 7 dias
- **[Quick Start](docs/quick-start.md)** - Comece em 30 minutos
- **[Cheat Sheet](docs/cheat-sheet.md)** - Comandos úteis

### Documentação Técnica

- **[Backend API](docs/backend-api.md)** - Endpoints NestJS
- **[Firebase Schema](docs/firebase-schema.md)** - Estrutura de dados
- **[HOMES-Engine](docs/homes-engine.md)** - Renderização Python
- **[Voice Control](docs/voice-control.md)** - Web Speech API

### Devlogs

Acompanhe o desenvolvimento diário em [`/devlog/`](devlog/)

---

## 🎬 Demo

### Video Demo (Coming Soon)
[![Demo Video](https://img.shields.io/badge/Demo-YouTube-red?style=for-the-badge&logo=youtube)]()

### Screenshots

| Voice Command | Real-time Progress | Video Ready |
|---------------|-------------------|-------------|
| ![Voice](assets/screenshots/voice.png) | ![Progress](assets/screenshots/progress.png) | ![Ready](assets/screenshots/ready.png) |

---

## 🛠️ Desenvolvimento

### Estrutura do Projeto

```
HOMES/ (este repo)
├── docs/              # Documentação unificada
├── devlog/            # Desenvolvimento diário
├── scripts/           # Scripts de setup/deploy
├── assets/            # Imagens, diagramas
└── .github/           # CI/CD workflows

HOMES-Engine/
├── core/              # Módulos principais
│   ├── ai_writer.py
│   ├── tts_engine.py
│   └── video_maker.py
├── integration/       # Comunicação com backend
└── assets/            # Fontes, B-roll, música

ai-video-factory/
├── src/               # Frontend React
├── server/src/        # Backend NestJS
│   ├── modules/
│   ├── websocket/
│   └── services/
└── Dockerfile

homes-prompt-manager/
├── src/
│   ├── components/    # React components
│   └── services/      # API clients
└── public/
```

### Rodando Localmente

```bash
# Terminal 1 - Backend
cd ai-video-factory
npm run start

# Terminal 2 - Frontend
cd homes-prompt-manager
npm run dev

# Terminal 3 - Worker
cd HOMES-Engine
python3 integration/queue_poller.py
```

### Testes

```bash
# Backend
cd ai-video-factory/server
npm run test

# Frontend
cd homes-prompt-manager
npm run test

# Engine
cd HOMES-Engine
python -m pytest tests/
```

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork os repositórios necessários
2. Crie uma branch (`git checkout -b feature/amazing-feature`)
3. Commit suas mudanças (`git commit -m 'feat: add amazing feature'`)
4. Push pra branch (`git push origin feature/amazing-feature`)
5. Abra um Pull Request

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para mais detalhes.

---

## 📝 Roadmap

- [x] Documentação completa
- [x] Backend NestJS + Firebase
- [x] Frontend React + Voice
- [x] HOMES-Engine renderização
- [ ] CI/CD pipelines
- [ ] Docker containers
- [ ] Mobile app (React Native)
- [ ] YouTube auto-upload
- [ ] Multi-language support
- [ ] Cloud deployment (Railway/Render)

---

## 🏆 Hackatime 2026

Este projeto faz parte do evento [Hackatime](https://hackatime.hackclub.com/) do Hack Club, uma maratona dedicada a valorizar o processo criativo através de **devlogs** e **projetos documentados**. 

### Objetivos

- ✅ Criar sistema funcional de produção de vídeos
- ✅ Documentar cada etapa do desenvolvimento
- ✅ Demonstrar pensamento arquitetural
- ✅ Código limpo e bem organizado
- ✅ Apresentação impactante

---

## 📄 Licença

MIT License - sinta-se livre para usar em seus projetos!

Ver [LICENSE](LICENSE) para mais informações.

---

## 👤 Autor

**Thiago Batista (EngThi)**

- GitHub: [@EngThi](https://github.com/EngThi)
- Hack Club: [Flavortown](https://flavortown.hackclub.com/)

---

## 🙏 Agradecimentos

- [Hack Club](https://hackclub.com/) pelo Hackatime
- [Google Gemini](https://ai.google.dev/) pela API gratuita
- [Termux](https://termux.dev/) pelo ambiente Android incrível
- Comunidade open-source

---

<div align="center">

**Desenvolvido com ❤️ para criadores de conteúdo**

[⭐ Star este projeto](https://github.com/EngThi/HOMES) • [🐛 Reportar Bug](https://github.com/EngThi/HOMES/issues) • [💡 Request Feature](https://github.com/EngThi/HOMES/issues)

</div>
