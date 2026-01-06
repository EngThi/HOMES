# 🗺️ HOMES Ecosystem Implementation Roadmap

Este documento serve como o **Guia Mestre de Implementação** para os desenvolvedores e agentes de IA que trabalharão nos repositórios do ecossistema. Siga esta ordem estrita para garantir o sucesso da integração.

---

## 🚦 Fase 1: O Motor (HOMES-Engine)
**Prioridade:** 🔴 CRÍTICA
**Repositório:** `../HOMES-Engine`

O motor de renderização deve ser capaz de receber um pedido simples e cuspir um vídeo, mesmo sem o backend estar pronto.

### Checklist de Implementação:
1.  [ ] **Dependências:** Criar `requirements.txt` (ffmpeg-python, edge-tts, requests).
2.  [ ] **Configuração:** Implementar `integration/config.py` lendo de `.env`.
3.  [ ] **API Client:** Criar `integration/api_client.py` para comunicação HTTP.
4.  [ ] **Queue Poller:** Implementar `integration/queue_poller.py` (Loop infinito que busca jobs).
5.  [ ] **Refatoração Core:** Garantir que `video_maker.py` aceite caminhos de arquivos como argumentos de função, não apenas CLI.

---

## 🚦 Fase 2: O Cérebro (ai-video-factory)
**Prioridade:** 🟡 ALTA
**Repositório:** `../ai-video-factory`

O backend orquestra tudo. Ele deve ser capaz de falar com o Firebase e gerar roteiros antes de mandar pro motor.

### Checklist de Implementação:
1.  [ ] **Firebase:** Configurar `firebase-admin` e conexão com Firestore.
2.  [ ] **Project Module:** Criar CRUD básico (`POST /projects`, `GET /projects/:id`).
3.  [ ] **Gemini Service:** Implementar prompt engineering para gerar roteiro JSON estruturado.
4.  [ ] **Polling Endpoint:** Criar rota `GET /projects/pending` para o Worker consumir.
5.  [ ] **Assets:** Implementar geração de imagens (ou mock inicial).

---

## 🚦 Fase 3: A Voz (homes-prompt-manager)
**Prioridade:** 🔵 MÉDIA
**Repositório:** `../homes-prompt-manager`

A interface do usuário. Pode ser feita por último, pois podemos testar o sistema via Postman/Curl.

### Checklist de Implementação:
1.  [ ] **Project Setup:** Migrar/Limpar para React + Vite + Tailwind.
2.  [ ] **Microfone:** Implementar Web Speech API (hook `useVoiceRecorder`).
3.  [ ] **API Connection:** Conectar com o backend (`axios.post('/projects')`).
4.  [ ] **Real-time:** Conectar Socket.IO para receber atualizações de status.

---

## 🚦 Fase 4: Integração & Polimento
**Prioridade:** 🟢 FINAL
**Local:** Todos os repositórios

### Checklist de Implementação:
1.  [ ] **Teste End-to-End:** Falar comando -> Backend processa -> Worker renderiza -> Vídeo aparece.
2.  [ ] **Notificações:** Fazer o Termux vibrar/notificar quando pronto.
3.  [ ] **Limpeza:** Scripts de auto-clean para arquivos temporários.

---

> **Nota para Agentes de IA:** Ao iniciar uma sessão, verifique em qual fase estamos e navegue para o diretório apropriado usando `cd ../[Nome-do-Repo]`.
