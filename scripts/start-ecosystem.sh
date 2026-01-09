#!/bin/bash
# start-ecosystem.sh
# Inicia todos os serviços do ecossistema HOMES

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║         🚀 HOMES ECOSYSTEM - STARTING SERVICES             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Iniciar HOMES AI (Feedback de Voz)
if [ -f "homes_agent.py" ]; then
    python3 homes_agent.py startup &
elif [ -f "../HOMES/homes_agent.py" ]; then
    python3 ../HOMES/homes_agent.py startup &
else
    # Fallback simples se homes_agent.py não existir
    termux-tts-speak "Iniciando sistema HOMES" 2>/dev/null || true
fi

# Diretório pai
PARENT_DIR="../"

# Função para verificar se porta está em uso
check_port() {
    lsof -i :$1 > /dev/null 2>&1
    return $?
}

# Limpar portas se necessário
if check_port 3000; then
    echo "⚠️  Porta 3000 já em uso. Limpando..."
    kill $(lsof -t -i:3000) 2>/dev/null || true
fi

if check_port 5173; then
    echo "⚠️  Porta 5173 já em uso. Limpando..."
    kill $(lsof -t -i:5173) 2>/dev/null || true
fi

# Criar diretório de logs
mkdir -p logs

echo "🔥 Iniciando serviços..."
echo ""

# 1. Backend (ai-video-factory)
if [ -d "${PARENT_DIR}/ai-video-factory" ]; then
    echo "📡 [1/3] Iniciando Backend (ai-video-factory)..."
    cd "${PARENT_DIR}/ai-video-factory"
    
    if [ -d "server" ]; then
        cd server
        npm run start > ../../HOMES/logs/backend.log 2>&1 &
        BACKEND_PID=$!
        echo "    ✅ Backend rodando (PID: $BACKEND_PID)"
        echo "    📝 Logs: logs/backend.log"
        echo "    🌐 URL: http://localhost:3000"
        cd ..
    fi
    
    cd - > /dev/null
    sleep 3
fi

# 2. Frontend (homes-prompt-manager)
if [ -d "${PARENT_DIR}/homes-prompt-manager" ]; then
    echo ""
    echo "🎨 [2/3] Iniciando Frontend (homes-prompt-manager)..."
    cd "${PARENT_DIR}/homes-prompt-manager"
    
    npm run dev > ../HOMES/logs/frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo "    ✅ Frontend rodando (PID: $FRONTEND_PID)"
    echo "    📝 Logs: logs/frontend.log"
    echo "    🌐 URL: http://localhost:5173"
    
    cd - > /dev/null
    sleep 3
fi

# 3. Worker (HOMES-Engine)
if [ -d "${PARENT_DIR}/HOMES-Engine" ]; then
    echo ""
    echo "🤖 [3/3] Iniciando Worker (HOMES-Engine)..."
    cd "${PARENT_DIR}/HOMES-Engine"
    
    if [ -f "integration/queue_poller.py" ]; then
        python3 integration/queue_poller.py > ../HOMES/logs/worker.log 2>&1 &
        WORKER_PID=$! 
        echo "    ✅ Worker rodando (PID: $WORKER_PID)"
        echo "    📝 Logs: logs/worker.log"
    else
        echo "    ⚠️  queue_poller.py não encontrado (normal se ainda não criou)"
    fi
    
    cd - > /dev/null
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                 ✅ TODOS OS SERVIÇOS ATIVOS                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Status:"
echo "   Backend:   http://localhost:3000"
echo "   Frontend: http://localhost:5173"
echo "   Worker:   Aguardando projetos..."
echo ""
echo "📝 Logs em tempo real:"
echo "   tail -f logs/backend.log"
echo "   tail -f logs/frontend.log"
echo "   tail -f logs/worker.log"
echo ""
echo "🛑 Para parar tudo:"
echo "   kill $BACKEND_PID $FRONTEND_PID $WORKER_PID"
echo ""
