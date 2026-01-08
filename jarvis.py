import subprocess
import sys
import time
import os

def run_termux_command(command, args=[]):
    """Executes a Termux API command."""
    try:
        subprocess.run([command] + args, check=True)
    except FileNotFoundError:
        print(f"Error: {command} not found. Ensure Termux API is installed.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing {command}: {e}")

def speak(text):
    """Uses TTS to speak text."""
    print(f"🗣️ JARVIS: {text}")
    run_termux_command("termux-tts-speak", [text])

def notify(title, message):
    """Sends a system notification."""
    run_termux_command("termux-notification", ["-t", title, "-c", message])

def vibrate(duration_ms=200):
    """Vibrates the device."""
    run_termux_command("termux-vibrate", ["-d", str(duration_ms)])

def check_battery():
    """Checks battery status (mock/simple implementation)."""
    try:
        result = subprocess.run(["termux-battery-status"], capture_output=True, text=True)
        if result.returncode == 0:
            data = json.loads(result.stdout)
            percentage = data.get("percentage", 0)
            status = data.get("status", "Unknown")
            return percentage, status
    except FileNotFoundError:
        pass
    return None, None

def startup_sequence():
    """Initiates the JARVIS startup sequence."""
    vibrate(100)
    notify("HOMES Protocol", "System Initialization Initiated")
    speak("Iniciando protocolos do sistema HOMES.")
    
    time.sleep(1)
    speak("Verificando integridade dos repositórios.")
    
    # Simple check of directories
    required_repos = ["../HOMES-Engine", "../ai-video-factory", "../homes-prompt-manager"]
    missing = []
    for repo in required_repos:
        if not os.path.exists(repo):
            missing.append(repo)
    
    if missing:
        speak(f"Atenção. Detectados {len(missing)} módulos ausentes.")
        print(f"Missing: {missing}")
    else:
        speak("Todos os módulos principais estão presentes.")

    time.sleep(1)
    speak("Sistema pronto para operação. Aguardando comandos.")
    vibrate(300)

if __name__ == "__main__":
    import json
    
    if len(sys.argv) > 1:
        command = sys.argv[1]
        if command == "speak" and len(sys.argv) > 2:
            speak(sys.argv[2])
        elif command == "startup":
            startup_sequence()
        elif command == "notify" and len(sys.argv) > 3:
            notify(sys.argv[2], sys.argv[3])
    else:
        startup_sequence()
