import subprocess
import sys
import time
import os
import json
import asyncio

# Configurações de Voz
VOICE_NEURAL = "pt-BR-AntonioNeural"
FALLBACK_ENGINE = "com.samsung.SMT"

def run_termux_command(command, args=[]):
    """Executes a Termux API command."""
    try:
        subprocess.run([command] + args, check=True, capture_output=True)
    except Exception:
        pass

def speak_neural(text):
    """Try to speak using Edge TTS (Neural)."""
    try:
        # Gera áudio temporário
        temp_file = "temp_voice.mp3"
        subprocess.run([
            "edge-tts", 
            "--text", text, 
            "--voice", VOICE_NEURAL, 
            "--write-media", temp_file
        ], check=True, capture_output=True)
        
        # Toca o áudio
        subprocess.run(["mpv", "--no-video", temp_file], check=True, capture_output=True)
        
        # Remove temporário
        if os.path.exists(temp_file):
            os.remove(temp_file)
        return True
    except Exception as e:
        print(f"⚠️ Erro Neural: {e}")
        return False

def speak_robotic(text):
    """Fallback to System TTS."""
    run_termux_command("termux-tts-speak", ["-e", FALLBACK_ENGINE, text])

def speak(text):
    """Smart speak: Neural if online, Robotic if offline."""
    print(f"🏠 HOMES: {text}")
    
    # Tenta neural primeiro, se falhar vai pra robótica
    if not speak_neural(text):
        speak_robotic(text)

def notify(title, message):
    """Sends a system notification."""
    run_termux_command("termux-notification", ["-t", title, "-c", message])

def vibrate(duration_ms=200):
    """Vibrates the device."""
    run_termux_command("termux-vibrate", ["-d", str(duration_ms)])

def startup_sequence():
    """Initiates the HOMES AI Agent startup sequence."""
    vibrate(100)
    notify("HOMES Protocol", "S.I. Inicializada")
    
    speak("Iniciando protocolos do sistema HOMES.")
    
    time.sleep(0.5)
    speak("Verificando módulos locais e conexões remotas.")
    
    # Check only Engine locally
    engine_path = "../HOMES-Engine"
    if os.path.exists(engine_path):
        speak("Motor de renderização local detectado e operacional.")
    else:
        speak("Atenção. Motor de renderização local não encontrado. Verifique o diretório Engine.")

    time.sleep(0.5)
    speak("Interface Web e Backend configurados como serviços remotos.")
    speak("Sistema em modo híbrido pronto para operação, Senhor.")
    vibrate(300)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        cmd = sys.argv[1]
        if cmd == "speak" and len(sys.argv) > 2:
            speak(sys.argv[2])
        elif cmd == "startup":
            startup_sequence()
    else:
        startup_sequence()