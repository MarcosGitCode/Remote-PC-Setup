#!/bin/bash
# Script de configuração do Servidor WoL

echo "Atualizando pacotes do sistema..."
pkg update && pkg upgrade -y || sudo apt update && sudo apt upgrade -y

echo "Instalando ferramentas de rede e SSH..."
pkg install openssh wakeonlan -y || sudo apt install openssh-server wakeonlan -y

echo "Configurando o atalho para inicialização..."
# O usuário deve substituir pelo MAC Address real do hardware destino
echo "alias ligar='wakeonlan SEU_MAC_ADDRESS_AQUI'" >> ~/.bashrc

echo "Configuração concluída!"
echo "Inicie o serviço SSH para liberar o acesso remoto."