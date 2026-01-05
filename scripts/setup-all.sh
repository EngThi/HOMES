#!/bin/bash
# setup-all.sh
# Setup completo do ecossistema HOMES

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         🏠 HOMES ECOSYSTEM - AUTOMATED SETUP               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função de log
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar se está na raiz do HOMES
if [ ! -f "README.md" ]; then
    log_error "Execute este script da raiz do repositório HOMES"
    exit 1
fi

# Diretório pai (onde estão todos os repos)
PARENT_DIR="../"

# 1. Clonar repos (se não existirem)
log_info "📦 Verificando repositórios..."

if [ ! -d "${PARENT_DIR}/HOMES-Engine" ]; then
    log_info "Clonando HOMES-Engine..."
    git clone https://github.com/EngThi/HOMES-Engine.git "${PARENT_DIR}/HOMES-Engine"
else
    log_warn "HOMES-Engine já existe, pulando..."
fi

if [ ! -d "${PARENT_DIR}/homes-prompt-manager" ]; then
    log_info "Clonando homes-prompt-manager..."
    git clone https://github.com/EngThi/homes-prompt-manager.git "${PARENT_DIR}/homes-prompt-manager"
else
    log_warn "homes-prompt-manager já existe, pulando..."
fi

if [ ! -d "${PARENT_DIR}/ai-video-factory" ]; then
    log_info "Clonando ai-video-factory..."
    git clone https://github.com/EngThi/ai-video-factory.git "${PARENT_DIR}/ai-video-factory"
else
    log_warn "ai-video-factory já existe, pulando..."
fi

# 2. Instalar dependências
log_info "📦 Instalando dependências..."

# HOMES-Engine (Python)
if [ -d "${PARENT_DIR}/HOMES-Engine" ]; then
    log_info "Instalando deps do HOMES-Engine..."
    cd "${PARENT_DIR}/HOMES-Engine"
    
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    else
        log_warn "requirements.txt não encontrado"
    fi
    
    cd - > /dev/null
fi

# homes-prompt-manager (Node)
if [ -d "${PARENT_DIR}/homes-prompt-manager" ]; then
    log_info "Instalando deps do homes-prompt-manager..."
    cd "${PARENT_DIR}/homes-prompt-manager"
    
    if [ -f "package.json" ]; then
        npm install
    else
        log_warn "package.json não encontrado"
    fi
    
    cd - > /dev/null
fi

# ai-video-factory (Node)
if [ -d "${PARENT_DIR}/ai-video-factory" ]; then
    log_info "Instalando deps do ai-video-factory..."
    cd "${PARENT_DIR}/ai-video-factory"
    
    if [ -f "package. json" ]; then
        npm install
        
        # Backend também
        if [ -d "server" ]; then
            cd server
            npm install
            cd .. 
        fi
    else
        log_warn "package.json não encontrado"
    fi
    
    cd - > /dev/null
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    ✅ SETUP COMPLETO                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
log_info "Próximo passo: Configurar . env em cada repositório"
log_info "Ver:  docs/setup-guide.md"
echo ""
