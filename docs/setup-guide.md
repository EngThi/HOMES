# 🚀 Setup Guide - HOMES Ecosystem

Este guia detalha o processo de instalação e configuração de todo o ecossistema HOMES (Heuristic Operative Modular Engineering System).

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

### Ambiente de Desenvolvimento
- **Git**: Controle de versão.
- **Node.js (v18+)**: Para o Frontend e Backend.
- **Python (v3.10+)**: Para o Engine de renderização.
- **FFmpeg**: Essencial para processamento de vídeo.
- **Termux (Android)**: Se for rodar o worker no celular.

### Contas e Chaves de API
- **Google Gemini API**: Chave para o modelo `gemini-2.5-flash`.
- **Firebase Project**: Firestore e Storage habilitados.
- **OpenAI / Stability AI (Opcional)**: Para geração de imagens (se não usar stock).

---

## 🛠️ Instalação Automática

O repositório `HOMES` possui scripts que automatizam o clone e instalação das dependências.

```bash
# 1. Clone o Hub Central
git clone https://github.com/EngThi/HOMES.git
cd HOMES

# 2. Execute o script de setup
# Este script clona os repositórios irmãos e roda npm install/pip install
bash scripts/setup-all.sh
```

---

## ⚙️ Instalação Manual (Passo a Passo)

Se preferir configurar manualmente ou se o script falhar.

### 1. Backend (ai-video-factory)

O cérebro da operação.

```bash
cd ..
git clone https://github.com/EngThi/ai-video-factory.git
cd ai-video-factory
npm install

# Configuração
cp .env.example .env
# Edite .env com:
# GEMINI_API_KEY=...
# FIREBASE_CREDENTIALS=...
```

### 2. Frontend (homes-prompt-manager)

A interface de controle.

```bash
cd ..
git clone https://github.com/EngThi/homes-prompt-manager.git
cd homes-prompt-manager
npm install

# Configuração
cp .env.example .env
# REACT_APP_API_URL=http://localhost:3000
```

### 3. Worker (HOMES-Engine)

O motor de renderização (idealmente no Termux).

```bash
cd ..
git clone https://github.com/EngThi/HOMES-Engine.git
cd HOMES-Engine

# Criar ambiente virtual (Opcional, mas recomendado)
python -m venv venv
source venv/bin/activate

# Instalar dependências
pip install -r requirements.txt

# Verificar FFmpeg
ffmpeg -version
```

---

## 🚀 Inicialização

Para rodar todo o sistema de uma vez:

```bash
# Na raiz do diretório HOMES
bash scripts/start-ecosystem.sh
```

Ou individualmente em terminais separados:

**Terminal 1 (Backend):**
```bash
cd ai-video-factory/server
npm run start:dev
```

**Terminal 2 (Frontend):**
```bash
cd homes-prompt-manager
npm run dev
```

**Terminal 3 (Worker):**
```bash
cd HOMES-Engine
python integration/queue_poller.py
```

---

## 📱 Configuração Específica: Termux (Android)

Para transformar seu celular em um render farm:

1. Instale o Termux via F-Droid.
2. Atualize os pacotes: `pkg update && pkg upgrade`.
3. Instale dependências do sistema:
   ```bash
   pkg install python git ffmpeg build-essential binutils
   ```
4. Siga os passos de instalação do **HOMES-Engine** acima.
5. (Opcional) Instale `termux-api` para notificações nativas.

---

## 🧪 Testando a Instalação

1. Acesse o frontend em `http://localhost:5173`.
2. Verifique se o ícone de conexão WebSocket está verde.
3. Fale ou digite: "Criar um vídeo teste".
4. Observe os logs do Backend recebendo a requisição.
5. Observe o Worker (Termux) pegar o job e iniciar o FFmpeg.

---

_Problemas? Consulte a [seção de Issues](https://github.com/EngThi/HOMES/issues)._
