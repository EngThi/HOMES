# 📜 HOMES Cheat Sheet

Comandos úteis e atalhos para facilitar o desenvolvimento e operação do ecossistema HOMES.

---

## 🚀 Orquestração (Repositório Hub)

| Comando | Descrição |
|---------|-----------|
| `bash scripts/setup-all.sh` | Clona e instala dependências de todos os repos. |
| `bash scripts/start-ecosystem.sh` | Inicia Backend, Frontend e Worker em background. |
| `tail -f logs/backend.log` | Acompanha logs do NestJS em tempo real. |
| `tail -f logs/frontend.log` | Acompanha logs do Vite/React. |
| `tail -f logs/worker.log` | Acompanha logs do renderizador Python. |
| `kill $(lsof -t -i:3000)` | Mata o processo rodando na porta 3000 (Backend). |
| `kill $(lsof -t -i:5173)` | Mata o processo rodando na porta 5173 (Frontend). |

---

## 🧠 Backend (`ai-video-factory`)

| Comando | Descrição |
|---------|-----------|
| `npm run start:dev` | Inicia o backend em modo watch. |
| `npm run lint` | Roda o linter para verificar qualidade de código. |
| `npm run test` | Executa testes unitários. |

---

## 🎨 Frontend (`homes-prompt-manager`)

| Comando | Descrição |
|---------|-----------|
| `npm run dev` | Inicia o servidor de desenvolvimento Vite. |
| `npm run build` | Gera a build de produção em `/dist`. |

---

## 🤖 Worker (`HOMES-Engine`)

| Comando | Descrição |
|---------|-----------|
| `python3 main.py` | Inicia o Worker em modo manual/interativo. |
| `python3 integration/queue_poller.py` | Inicia o Worker em modo escuta (Backend). |
| `pip install -r requirements.txt` | Atualiza dependências do Python. |

---

## 📱 Comandos Termux Úteis

| Comando | Descrição |
|---------|-----------|
| `termux-wake-lock` | Impede o Android de suspender a CPU (essencial para render). |
| `termux-notification -c "HOMES" -t "Render Pronto!"` | Dispara notificação nativa. |
| `termux-setup-storage` | Garante acesso à pasta `/sdcard`. |

---

## 🛠️ Debugging FFmpeg

Para testar a renderização de uma única cena manualmente:
```bash
ffmpeg -loop 1 -i image.jpg -i audio.mp3 -c:v libx264 -t 5 -pix_fmt yuv420p -shortest out.mp4
```
*(Cria um vídeo de 5s a partir de uma imagem e áudio)*
