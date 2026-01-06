# 🤖 HOMES-Engine: O Motor de Renderização

O **HOMES-Engine** é o componente responsável pela "mão de obra" pesada: transformar dados e imagens em um vídeo MP4 final. Ele foi desenhado para rodar de forma eficiente em ambientes limitados como o **Termux** (Android).

---

## 🏗️ Arquitetura Interna

O Worker é modular e dividido em 3 núcleos principais:

### 1. `ai_writer.py` (Local Fallback)
Embora o Backend gere o roteiro, o Engine possui uma versão simplificada para testes offline usando a API do Gemini diretamente.

### 2. `tts_engine.py` (Narração)
Usa o **Edge-TTS** para gerar vozes neurais de alta qualidade sem custo.
- **Voz Padrão:** `pt-BR-AntonioNeural` ou `pt-BR-FranciscaNeural`.
- **Output:** Gera arquivos `.mp3` para cada cena e um arquivo consolidado.

### 3. `video_maker.py` (Composição)
O coração que orquestra o **FFmpeg**.
- **Processo:**
  1. Redimensiona imagens para o Aspect Ratio alvo (ex: 720x1280).
  2. Aplica efeito **Ken Burns** (zoom/pan suave) para dar movimento.
  3. Sobrepõe áudio da narração + música de fundo (com ducking).
  4. Gera e queima legendas no vídeo (burn-in).
  5. Codifica o MP4 final.

---

## 📂 Estrutura de Arquivos

```
HOMES-Engine/
├── core/
│   ├── ai_writer.py    # Geração de texto
│   ├── tts_engine.py   # Voz
│   └── video_maker.py  # FFmpeg Logic
├── integration/
│   ├── api_client.py   # Comunicação com NestJS
│   └── queue_poller.py # Loop de busca de tarefas
├── assets/             # Fontes, Overlays, BGMs
└── output/             # Pasta de cache e vídeos finais
```

---

## 🛠️ Requisitos de Instalação (Termux)

```bash
pkg update && pkg upgrade
pkg install python ffmpeg termux-api
pip install edge-tts requests python-dotenv
```

---

## ⚙️ Configurações (integration/config.py)

```python
POLLING_INTERVAL = 10  # segundos
MAX_RETRIES = 3
RENDER_QUALITY = "720p" # 720p ou 1080p
OUTPUT_PATH = "/sdcard/Download/HOMES/"
```

---

## 📈 Otimização de Performance

Como o celular tem CPU ARM, evitamos re-encodagem desnecessária:
- Usamos `-preset ultrafast` ou `-preset superfast` no FFmpeg.
- Priorizamos o codec `libx264` por compatibilidade universal.
- Se disponível, o script tenta usar `h264_mediacodec` (Hardware Acceleration do Android).
