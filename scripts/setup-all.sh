#!/bin/bash
# setup-all.sh
# Setup inteligente do ecossistema HOMES (Modo Híbrido/Termux)

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║      🏠 HOMES ECOSYSTEM - HYBRID SETUP (MOBILE HUB)        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função de log
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1"; }

# Diretório pai (onde estão todos os repos)
PARENT_DIR="../"

# 1. Configurar HOMES-Engine (Local - CRÍTICO)
echo ""
log_step "Verificando Motor de Renderização (Local)..."

if [ ! -d "${PARENT_DIR}/HOMES-Engine" ]; then
    log_info "Clonando HOMES-Engine..."
    git clone https://github.com/EngThi/HOMES-Engine.git "${PARENT_DIR}/HOMES-Engine"
else
    log_info "✅ HOMES-Engine já está instalado."
fi

# Instalar dependências do Engine
if [ -d "${PARENT_DIR}/HOMES-Engine" ]; then
    log_info "📦 Atualizando dependências do Python..."
    pip install -r "${PARENT_DIR}/HOMES-Engine/requirements.txt" || log_warn "Falha ao instalar deps via pip. Verifique manualmente."
fi

# 2. Configurar Serviços Remotos (Cloud)
echo ""
log_step "Configurando Arquitetura Híbrida..."

echo "Neste modo, o Backend e Frontend rodam na nuvem/GitHub Pages."
echo "Não clonaremos repositórios Node.js pesados para o celular."

# 3. Setup de Ambiente (.env)
echo ""
log_step "Configurando Variáveis de Ambiente..."

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        log_info "✅ Arquivo .env criado a partir do exemplo."
        echo "⚠️  AÇÃO NECESSÁRIA: Edite o arquivo .env com as URLs reais do seu backend!"
    else
        log_warn "Arquivo .env.example não encontrado."
    fi
else
    log_info "✅ Arquivo .env já existe."
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  ✅ SETUP CONCLUÍDO                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🤖 Para iniciar o Hub com Agente de Voz:"
echo "   bash scripts/start-ecosystem.sh"
echo ""