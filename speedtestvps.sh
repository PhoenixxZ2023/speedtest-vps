#!/bin/bash

# Definir cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar se o speedtest-cli já está instalado
if [ -f "speedtest-cli" ]; then
    echo -e "${YELLOW}O script de teste de velocidade já está instalado.${NC}"
else
    echo "================================================="
    echo "            Baixando script de teste de velocidade"
    echo "================================================="
    wget -O speedtest-cli https://raw.githubusercontent.com/PhoenixxZ2023/speedtest-vps/master/speedtestvps.sh
    chmod +x speedtest-cli
    echo "Script de teste de velocidade instalado com sucesso!"
fi

# Função para testar a velocidade da internet e exibir o link
function test_speed {
    echo -e "${GREEN}Testando velocidade da internet...${NC}"
    speedtest_result=$(./speedtest-cli --simple)
    server_id=$(echo "$speedtest_result" | grep -oP 'Hosted by \K.+(?= \()')
    server_ip=$(echo "$speedtest_result" | grep -oP '\((\d{1,3}\.){3}\d{1,3}\)')
    echo -e "${GREEN}Utilizando o servidor $server_id ($server_ip)${NC}"
    echo "$speedtest_result"
    echo -e "${GREEN}Link do resultado: https://www.speedtest.net/result/$(./speedtest-cli --share | grep -oP 'https://www.speedtest.net/result/\S+')${NC}"
    read -p "${YELLOW}Pressione Enter para retornar ao menu principal...${NC}"
}

# Exibir menu
function show_menu {
    clear
    echo -e "${GREEN}=================================================${NC}"
    echo -e "${GREEN}                Speedtest Menu                ${NC}"
    echo -e "${GREEN}=================================================${NC}"
    echo -e "${YELLOW}Selecione uma opção:${NC}"
    echo -e "${YELLOW}1. Testar velocidade da internet${NC}"
    echo -e "${YELLOW}2. Sair${NC}"
    echo -e "${GREEN}=================================================${NC}"
    read -p "${YELLOW}Opção: ${NC}" option

    # Executar a ação baseada na opção escolhida
    case $option in
        1)
            test_speed
            ;;
        2)
            echo -e "${YELLOW}Saindo do script...${NC}"
            exit 0
            ;;
        *)
            echo -e "${YELLOW}Opção inválida. Por favor, escolha uma opção válida.${NC}"
            ;;
    esac
}

# Mensagem de boas-vindas
echo -e "${YELLOW}Bem-vindo ao Speedtest CLI!${NC}"

# Executar o menu
while true; do
    show_menu
done
