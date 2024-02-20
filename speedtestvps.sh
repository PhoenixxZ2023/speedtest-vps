#!/bin/bash

# Cores ANSI
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sem cor

# Função para testar a velocidade da internet
function test_speed {
    clear
    echo -e "${BLUE}Testando a velocidade da internet...${NC}"
    speedtest-cli
    echo -e "\n${YELLOW}Para mais informações e testes detalhados, visite o Speedtest da Ookla em:${NC}"
    echo -e "${YELLOW}https://www.speedtest.net/${NC}"
    read -p "Pressione Enter para retornar ao menu..." input
}

# Exibir menu
function show_menu {
    clear
    echo -e "${GREEN}================================================="
    echo -e "            Teste de Velocidade da Internet"
    echo -e "=================================================${NC}"
    echo -e "${YELLOW}Selecione uma opção:${NC}"
    echo -e "${BLUE}1.${NC} Testar velocidade da internet"
    echo -e "${BLUE}2.${NC} Sair"
    echo -e "${GREEN}=================================================${NC}"
    read -p "Opção: " option

    # Executar a ação baseada na opção escolhida
    case $option in
        1)
            test_speed
            ;;
        2)
            echo "Saindo do script..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Por favor, escolha uma opção válida."
            ;;
    esac
}

# Instalar speedtest-cli
echo -e "${GREEN}================================================="
echo -e "            Instalando speedtest-cli"
echo -e "=================================================${NC}"
sudo apt update
sudo apt install speedtest-cli -y

# Verificar se a instalação foi bem-sucedida
if ! command -v speedtest-cli &>/dev/null; then
    echo "Houve um erro durante a instalação do speedtest-cli."
    exit 1
fi

echo "Instalação concluída com sucesso!"

# Executar o menu
show_menu
