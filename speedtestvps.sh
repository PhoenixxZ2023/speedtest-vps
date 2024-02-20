#!/bin/bash

# Função para testar a velocidade da internet
function test_speed {
    speedtest
}

# Exibir menu
function show_menu {
    while true; do
        clear
        echo "================================================="
        echo "                  Menu Principal"
        echo "================================================="
        echo "Selecione uma opção:"
        echo "1. Testar velocidade da internet"
        echo "2. Sair"
        echo "================================================="
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
    done
}

# Instalar speedtest-cli
echo "================================================="
echo "            Instalando speedtest-cli"
echo "================================================="
sudo apt update
sudo apt install speedtest-cli -y

# Verificar se a instalação foi bem-sucedida
if ! command -v speedtest &>/dev/null; then
    echo "Houve um erro durante a instalação do speedtest-cli."
    exit 1
fi

echo "Instalação concluída com sucesso!"

# Executar o menu
show_menu
