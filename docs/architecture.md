# 🏗️ Arquitetura do Sistema HOMES

Este documento detalha a arquitetura técnica do **H.O.M.E.S (Heuristic Operative Modular Engineering System)**. O sistema segue um padrão de microserviços simplificado (Service-Oriented Architecture), otimizado para rodar em um ambiente híbrido (Cloud + Edge/Mobile).

---

## 📐 Diagrama de Componentes

```mermaid
graph TD
    User((Usuario)) -->|Voz/Texto| Frontend[homes-prompt-manager]
    
    subgraph "Interface Layer (React)"
        Frontend -->|Web Speech API| STT[Speech to Text]
        Frontend -->|Socket.IO| WS_Client[WebSocket Client]
        Frontend -->|HTTP REST| API_Client[Axios]
    end
    
    subgraph "Orchestration Layer (NestJS)"
        API_Client -->|POST /create| Backend[ai-video-factory]
        Backend <-->|Auth/DB| Firebase[(Firestore)]
        Backend -->|Generation| Gemini[Google Gemini 2.5 Flash]
        Backend -->|Events| WS_Gateway[Socket Gateway]
    end
    
    subgraph "Production Layer (Python/Termux)"
        Worker[HOMES-Engine] -->|Polls| Backend
        Worker -->|TTS| EdgeTTS[Microsoft Edge TTS]
        Worker -->|Composition| FFmpeg[FFmpeg Binary]
        Worker -->|Storage| LocalStorage[/sdcard/Download]
    end

    WS_Gateway -.->|Updates| WS_Client
    Worker -.->|Update Status| Backend
```

---

## 🔍 Detalhamento dos Módulos

### 1. Frontend: `homes-prompt-manager`
Interface de comando e controle.
- **Responsabilidade:** Capturar intenção do usuário e exibir progresso.
- **Tech:** React 19, Vite, Tailwind.
- **Feature Chave:** Voice Activity Detection (VAD) para iniciar gravação automaticamente ao falar "Jarvis" ou "Homes".

### 2. Backend: `ai-video-factory`
Cérebro da operação.
- **Responsabilidade:** Transformar intenção vaga ("Vídeo sobre café") em roteiro estruturado e assets.
- **Tech:** NestJS, TypeScript.
- **Fluxo de IA:**
  1. Recebe Prompt.
  2. Consulta `BrandProfile` (preferências do usuário).
  3. Gemini gera: Roteiro, Keywords para imagem, Sugestão de BGM.
  4. Dispara geração de imagens (DALL-E 3 ou Stable Diffusion via API, ou busca Stock).
  5. Salva estado `PENDING` no Firestore.

### 3. Worker: `HOMES-Engine`
O operário fabril rodando no Android.
- **Responsabilidade:** Baixar assets e renderizar o MP4 final.
- **Tech:** Python 3, FFmpeg.
- **Limitações:** Processamento limitado pela CPU do celular.
- **Otimização:**
  - Renderiza em 720p por padrão (mais rápido).
  - Usa aceleração de hardware do FFmpeg (`mediacodec`) se disponível.
  - Processa áudio e vídeo em streams separados antes do merge final.

---

## 🔄 Fluxo de Dados (Data Flow)

### Fase 1: Ingestão
1. **User:** "Faça um vídeo motivacional curto."
2. **Frontend:** Envia `{ prompt: "motivacional curto", type: "voice" }` para API.
3. **Backend:** Cria ID de projeto `proj_123`, status `ANALYZING`.

### Fase 2: Processamento AI
1. **Backend:** Pede ao Gemini: "Roteiro de 30s motivacional".
2. **Gemini:** Retorna JSON com falas e descrições visuais.
3. **Backend:** Atualiza status `GENERATING_ASSETS`.

### Fase 3: Renderização (Edge)
1. **Worker:** Detecta `proj_123` via Polling.
2. **Worker:** Baixa JSON do roteiro.
3. **Worker:** Gera áudio (TTS) para cada parágrafo.
4. **Worker:** Monta timeline no FFmpeg.
5. **Worker:** Renderiza `output.mp4`.

### Fase 4: Entrega
1. **Worker:** Move arquivo para pasta pública do Android.
2. **Worker:** Envia notificação nativa Android.
3. **Worker:** Marca projeto como `COMPLETED`.
4. **Frontend:** Exibe player de vídeo.

---

## 💾 Modelo de Dados (Firestore)

### Collection: `projects`
```json
{
  "id": "proj_123",
  "userId": "user_abc",
  "status": "COMPLETED", // PENDING, PROCESSING, FAILED
  "input": {
    "originalPrompt": "Vídeo sobre café",
    "timestamp": "2026-01-05T14:00:00Z"
  },
  "script": [
    {
      "text": "O café é a energia do mundo.",
      "duration": 3.5,
      "visualPrompt": "Coffee beans falling in slow motion"
    }
  ],
  "assets": {
    "audioUrl": "...",
    "videoPath": "/sdcard/Download/homes_123.mp4"
  }
}
```

---

## 🔒 Segurança

- **API Keys:** Armazenadas apenas no `.env` do servidor. Frontend não tem acesso a chaves do Gemini.
- **CORS:** Restrito ao domínio do frontend (ou localhost em dev).
- **Validação:** Zod schemas para validar entrada e saída de JSONs.

