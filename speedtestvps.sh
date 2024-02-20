#!/bin/bash

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
    echo "Testando velocidade da internet..."
    ./speedtest-cli --simple > speedtest_result.txt
    cat speedtest_result.txt
    server_ip=$(./speedtest-cli --server | grep -oP 'Server: \K\d+\.\d+\.\d+\.\d+')
    echo "IP do servidor: $server_ip"
    echo "Link do resultado: https://www.speedtest.net/result/$(grep -oP 'Share result: \Khttps://www.speedtest.net/result/.+$' speedtest_result.txt)"
    rm speedtest_result.txt
    read -p "Pressione Enter para retornar ao menu principal..."
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
            echo "Saindo do script..."
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
