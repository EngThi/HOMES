# 📡 Backend API Documentation

A API do HOMES é construída com **NestJS** e serve como o orquestrador central entre o Frontend, a IA e o Worker de renderização.

---

## 🔑 Autenticação

Atualmente, o sistema utiliza uma chave de API simples passada no header ou autenticação via Firebase Auth (em implementação).
`X-API-KEY: your_api_key_here`

---

## 🛠️ Endpoints de Projetos

### 1. Criar Novo Projeto
Inicia o processo de geração de roteiro e assets.
- **URL:** `/api/projects`
- **Método:** `POST`
- **Body:**
  ```json
  {
    "prompt": "História dos Samurais",
    "style": "cinematic",
    "aspectRatio": "9:16"
  }
  ```
- **Resposta (201):**
  ```json
  {
    "id": "proj_abc123",
    "status": "PENDING_SCRIPT"
  }
  ```

### 2. Listar Projetos Pendentes
Utilizado pelo Worker (Polling).
- **URL:** `/api/projects/pending`
- **Método:** `GET`
- **Resposta (200):** Lista de objetos de projeto com status `READY_TO_RENDER`.

### 3. Obter Detalhes do Projeto
- **URL:** `/api/projects/:id`
- **Método:** `GET`

### 4. Atualizar Status/Concluir
Utilizado pelo Worker para avisar que terminou a renderização.
- **URL:** `/api/projects/:id/complete`
- **Método:** `PATCH`
- **Body:**
  ```json
  {
    "videoUrl": "https://storage.firebase.../video.mp4",
    "renderTime": 145
  }
  ```

---

## 🔌 WebSockets (Socket.IO)

O Backend emite eventos para o Frontend para manter o usuário informado sem refresh.

| Evento | Payload | Descrição |
|--------|---------|-----------|
| `project.status` | `{ id, status, message }` | Mudança geral de estado. |
| `project.log` | `{ id, text }` | Logs detalhados da IA ou do FFmpeg. |
| `project.completed`| `{ id, videoUrl }` | Notificação de conclusão final. |

---

## 🏗️ Estrutura de Pastas (ai-video-factory)

```
server/
├── src/
│   ├── modules/
│   │   ├── project/      # CRUD e lógica de projetos
│   │   ├── ai/           # Integração Gemini
│   │   └── storage/      # Upload para Firebase/S3
│   ├── gateway/          # WebSocket (Socket.IO)
│   └── common/           # DTOs, Interfaces, Utils
```
