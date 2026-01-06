# 🚀 Quick Start Guide

Bem-vindo ao **HOMES**! Este guia rápido ajudará você a colocar o ecossistema completo para rodar em menos de 10 minutos.

---

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter instalado:
- **Node.js 18+** e **npm**
- **Python 3.8+** e **pip**
- **Git**
- **FFmpeg** (Instalado e acessível no PATH)

---

## ⚡ Instalação em 3 Passos

### 1. Clonar o Hub e Setup Automático
O repositório `HOMES` contém os scripts de orquestração que baixam e configuram os outros 3 repositórios automaticamente.

```bash
git clone https://github.com/EngThi/HOMES.git
cd HOMES
bash scripts/setup-all.sh
```

### 2. Configurar Variáveis de Ambiente
Você precisará de chaves de API para o Gemini. Copie o arquivo de exemplo e edite com suas chaves:

```bash
cp .env.example .env
# Edite o .env com seu editor favorito (nano, vim, code)
```

### 3. Iniciar o Ecossistema
Rode o script de orquestração para subir o Backend, Frontend e o Worker simultaneamente:

```bash
bash scripts/start-ecosystem.sh
```

---

## 🌐 Acesso aos Serviços

Após iniciar, os serviços estarão disponíveis nos seguintes endereços:

- **Frontend (UI):** [http://localhost:5173](http://localhost:5173)
- **Backend (API):** [http://localhost:3000](http://localhost:3000)
- **Worker (Logs):** Veja em `logs/worker.log`

---

## 🎤 Primeiro Teste

1. Abra o Frontend no seu navegador.
2. Clique no botão de microfone (ou digite no campo de prompt).
3. Diga: *"Faça um vídeo curto sobre as curiosidades de Marte"*.
4. Acompanhe o progresso na tela.
5. Quando terminar, o vídeo aparecerá para download ou visualização!

---

## 📱 Dica para Mobile (Termux)

Se estiver rodando no Android via Termux:
1. Certifique-se de dar permissão de armazenamento: `termux-setup-storage`.
2. Instale o pacote da API: `pkg install termux-api`.
3. O vídeo final será salvo em `/sdcard/Download/`.

---

Para mais detalhes, consulte o [Setup Guide Completo](setup-guide.md).
