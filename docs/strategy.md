# 🗺️ HOMES Strategy - Hackatime 2026 Roadmap

Este documento define a estratégia de desenvolvimento para o evento **Hackatime 2026**. O objetivo é construir um MVP funcional de produção de vídeos automatizada em 7 dias, documentando todo o processo.

---

## 📅 Cronograma de 7 Dias

### Dia 1: Fundação e Arquitetura (05/01) ✅
- [x] Definição do escopo e arquitetura 3-tier.
- [x] Configuração do repositório central (HOMES Hub).
- [x] Estrutura de documentação e Devlogs.
- [x] Scripts de automação (`setup-all.sh`, `start-ecosystem.sh`).
- [x] Configuração do WakaTime para métricas.

### Dia 2: O Motor de Renderização (HOMES-Engine)
**Foco:** Garantir que o Termux consiga renderizar vídeo a partir de inputs simples.
- [ ] Implementar `integration/queue_poller.py` para buscar tarefas.
- [ ] Testar geração de TTS local (Edge-TTS) no Android.
- [ ] Validar pipeline FFmpeg com assets locais.
- [ ] Teste de ponta a ponta: JSON Input -> Vídeo MP4.

### Dia 3: O Cérebro (ai-video-factory)
**Foco:** Backend robusto para orquestrar IA e dados.
- [ ] Configurar Firebase Firestore (Collections: `projects`, `users`).
- [ ] Implementar Service de Integração com Gemini 2.5 Flash.
- [ ] Criar endpoint `POST /api/project/create`.
- [ ] Implementar WebSocket Gateway para feedback em tempo real.

### Dia 4: A Voz de Comando (homes-prompt-manager)
**Foco:** Interface fluida e controle por voz.
- [ ] Migração/Setup do projeto React + Vite.
- [ ] Implementar Web Speech API para transcrição em tempo real.
- [ ] Criar UI "Cyberpunk" responsiva para mobile.
- [ ] Conectar Socket.IO client com o Backend.

### Dia 5: Integração Total (The "Glue" Day)
**Foco:** Conectar as três partes.
- [ ] Fluxo completo: Voz (Frontend) -> Backend (Gemini) -> Termux (Render) -> Notificação.
- [ ] Ajuste de timeouts e tratamento de erros.
- [ ] Implementar "fallback" caso a geração de imagem falhe.
- [ ] Otimização de prompts para consistência visual.

### Dia 6: Polimento e UX
**Foco:** Tornar a experiência mágica.
- [ ] Melhorar transições de vídeo (Ken Burns aprimorado).
- [ ] Adicionar legendas automáticas sincronizadas (SRT/Burn-in).
- [ ] Ducking de áudio (baixar música quando houver fala).
- [ ] Feedback visual detalhado no Frontend.

### Dia 7: Demo Day e Documentação Final
**Foco:** Entregáveis do Hackathon.
- [ ] Gravar vídeo de demonstração (Demo Video).
- [ ] Finalizar README.md com screenshots reais.
- [ ] Revisão final de todos os devlogs.
- [ ] Submissão no Hack Club.

---

## 🎯 KPIs de Sucesso

1. **Tempo de Renderização:** < 3 minutos para um vídeo de 1 minuto (no celular).
2. **Autonomia:** O usuário só deve precisar falar o tema; o resto deve ser automático.
3. **Estabilidade:** 5 vídeos gerados em sequência sem crash.
4. **Qualidade de Código:** Linting limpo, Typescript rigoroso no backend.

---

## 🛡️ Riscos e Mitigação

| Risco | Probabilidade | Mitigação |
|-------|--------------|-----------|
| Termux matar o processo em background | Alta | Usar `termux-wake-lock` e notificação persistente. |
| Cota da API do Gemini estourar | Média | Implementar cache de roteiros e rate limiting. |
| Latência do Edge-TTS | Baixa | Cache local de vozes geradas. |
| Falha na geração de imagens | Média | Ter um banco de imagens "stock" genéricas como fallback. |

---

## 🛠️ Stack Tecnológica (Confirmada)

- **Frontend:** React 19, Vite, TailwindCSS.
- **Backend:** NestJS, Socket.IO, Firebase Admin SDK.
- **Worker:** Python 3.10+, FFmpeg, Edge-TTS.
- **Infra:** Termux (Android), GitHub.

---

_Documento vivo. Última atualização: 05/01/2026_
