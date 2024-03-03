#!/bin/bash

# Função para instalar o speedtest-cli e adicionar a função speedtest ao ~/.bashrc
install_speedtest() {
    # Instala o speedtest-cli
    sudo apt-get update
    sudo apt-get install speedtest-cli -y

    # Adiciona a função speedtest ao ~/.bashrc
    echo 'speedtest() {
        if ! command -v speedtest-cli &> /dev/null; then
            echo "speedtest-cli não está instalado. Você pode instalá-lo com 'sudo apt install speedtest-cli'."
            return 1
        fi
        speedtest-cli "$@"
    }' >> ~/.bashrc

    # Atualiza o ~/.bashrc
    source ~/.bashrc

    echo "O speedtest-cli foi instalado com sucesso. Você pode executar 'speedtest' para testar a velocidade da sua internet."
}

# Função para mostrar o menu
show_menu() {
    echo "Menu:"
    echo "1. Ativar speedtest-cli"
    echo "2. Fazer teste de velocidade"
    echo "3. Sair"
}

# Executa a função install_speedtest
install_speedtest

# Loop do menu
while true; do
    show_menu
    read -p "Selecione uma opção: " choice
    case $choice in
        1)
            # Ativa o speedtest-cli
            source ~/.bashrc
            echo "speedtest-cli ativado."
            ;;
        2)
            # Faz o teste de velocidade
            speedtest
            ;;
        3)
            # Sai do script
            echo "Saindo."
            exit
            ;;
        *)
            echo "Opção inválida."
            ;;
    esac
done
