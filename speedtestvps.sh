#!/bin/bash

# Função para definir as cores
function set_color {
    case $1 in
        green) color="\e[32m" ;;
        yellow) color="\e[33m" ;;
        reset) color="\e[0m" ;;
        *) color="" ;;
    esac
    echo -ne "$color"
}

# Verificar se o speedtest-cli já está instalado
if command -v speedtest &>/dev/null; then
    echo "O speedtest-cli já está instalado."
else
    echo "================================================="
    echo -e "$(set_color yellow)            Instalando speedtest-cli$(set_color reset)"
    echo "================================================="
    sudo apt update
    sudo apt install speedtest-cli -y

    # Verificar se a instalação foi bem-sucedida
    if ! command -v speedtest &>/dev/null; then
        echo "Houve um erro durante a instalação do speedtest-cli."
        exit 1
    fi

    echo "Instalação concluída com sucesso!"
fi

# Função para testar a velocidade da internet e exibir o link
function test_speed {
    echo "Testando velocidade da internet..."
    speedtest-cli --simple > speedtest_result.txt
    cat speedtest_result.txt
    echo "Link do resultado: https://www.speedtest.net/result/$(grep -oP 'Share result: \Khttps://www.speedtest.net/result/.+$' speedtest_result.txt)"
    rm speedtest_result.txt
    read -p "$(set_color yellow)Pressione Enter para retornar ao menu principal...$(set_color reset)"
}

# Exibir menu
function show_menu {
    clear
    echo -e "$(set_color green)=================================================$(set_color reset)"
    echo -e "$(set_color green)                Speedtest Menu                $(set_color reset)"
    echo -e "$(set_color green)=================================================$(set_color reset)"
    echo -e "$(set_color yellow)Selecione uma opção:$(set_color reset)"
    echo -e "$(set_color yellow)1. Testar velocidade da internet$(set_color reset)"
    echo -e "$(set_color yellow)2. Sair$(set_color reset)"
    echo -e "$(set_color green)=================================================$(set_color reset)"
    read -p "$(set_color yellow)Opção:$(set_color reset) " option

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
            echo "$(set_color yellow)Opção inválida. Por favor, escolha uma opção válida.$(set_color reset)"
            ;;
    esac
}

# Mensagem de boas-vindas
echo "Bem-vindo ao Speedtest CLI!"

# Executar o menu
while true; do
    show_menu
done
