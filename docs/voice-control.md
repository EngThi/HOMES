# 🎤 Voice Control & Speech API

O controle por voz é o diferencial do HOMES, permitindo uma interface "Zero UI" onde o usuário interage com o sistema como se estivesse conversando com um assistente.

---

## 🛠️ Tecnologias Utilizadas

1. **Web Speech API (STT):** Nativa do navegador para transcrição de voz em texto.
2. **Web Audio API:** Para visualização de ondas sonoras e detecção de silêncio.
3. **Edge-TTS (no Worker):** Para o feedback de voz do sistema (opcional no frontend).

---

## 🔄 Fluxo de Comando de Voz

1. **Wake Word Detection:** O frontend escuta continuamente por "Jarvis" ou "Homes" (usando bibliotecas leves como Porcupine ou detecção simples de keywords).
2. **Listening Mode:** A interface muda para um estado visual "ativo" (glow pulses).
3. **Capture:** O usuário fala o comando: *"Crie um vídeo sobre o império romano"*.
4. **Processing:** O texto transcrito é enviado via WebSocket para o Backend.
5. **Confirmation:** O sistema pode responder (via TTS do browser): *"Entendido. Gerando vídeo sobre o Império Romano agora."*

---

## 💻 Exemplo de Implementação (Frontend)

```javascript
const recognition = new window.webkitSpeechRecognition();
recognition.continuous = false;
recognition.lang = 'pt-BR';

recognition.onresult = (event) => {
  const transcript = event.results[0][0].transcript;
  console.log("Comando recebido:", transcript);
  socket.emit('voice-command', { text: transcript });
};

function startListening() {
  recognition.start();
}
```

---

## 🎯 Comandos Suportados (Previsão)

| Comando | Ação |
|---------|------|
| "Crie um vídeo sobre [Tema]" | Inicia geração completa. |
| "Status do projeto" | Retorna progresso atual via voz/texto. |
| "Cancelar renderização" | Para o processo atual no Worker. |
| "Mudar estilo para Cinematic" | Altera configuração padrão do usuário. |

---

## ⚠️ Limitações e Desafios

- **Ruído de Fundo:** O uso de VAD (Voice Activity Detection) é essencial para não processar ruído.
- **Privacidade:** O microfone só deve ser ativado após interação explícita ou Wake Word local.
- **Conexão:** A transcrição depende da API do Google (no Chrome) e pode falhar sem internet.
```
