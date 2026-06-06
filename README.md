# Servidor de Inicialização Remota de Hardware (WoL via SSH & VPN Mesh)

Este projeto implementa uma solução de servidor de borda residencial de baixo custo para gerenciar e ligar computadores remotamente de qualquer lugar do mundo. A arquitetura contorna restrições de CGNAT de operadoras sem a necessidade de abertura de portas (Port Forwarding) no roteador principal.

## 💻 Hardware Suportado
A solução foi desenhada para reaproveitar hardware legado que consuma pouca energia rodando 24/7:
* **Ambiente Mobile:** Dispositivos Android antigos dedicados (através do emulador de terminal Termux).
* **Ambiente Desktop:** Computadores ou notebooks obsoletos configurados com uma distribuição Linux (Debian, Ubuntu Server, Fedora, etc.).

## 🛠️ Tecnologias e Conceitos Aplicados
* **Ambientes Linux:** Gerenciamento de pacotes, caminhos absolutos e Shell Scripting (Bash).
* **Segurança e Acesso Remoto:** Protocolo SSH (Secure Shell) com criptografia ponta a ponta.
* **Arquitetura de Redes:** VPN Mesh baseada no protocolo WireGuard (via Tailscale) para tunelamento seguro entre redes distintas.
* **Camada de Enlace:** Protocolo Wake-on-LAN (WoL) para injeção de *Magic Packets* via Broadcast.

## 📐 Arquitetura do Fluxo de Dados

1. **Disparo:** O cliente inicia uma sessão SSH de fora da rede apontando para o IP privado gerado pela VPN Mesh.
2. **Autenticação:** O servidor Linux atua como gateway de borda, validando o acesso com segurança.
3. **Execução:** Um alias em Bash dispara o utilitário `wakeonlan` com o endereço físico (MAC Address) do computador destino.
4. **Acionamento:** O pacote mágico é transmitido via broadcast na interface de rede local, acordando o hardware destino através da placa-mãe.

## ⚙️ Como Replicar

1. Instale o ambiente de terminal (Termux no Android ou terminal nativo no Linux desktop).
2. Clone este repositório:
   ```bash
   git clone https://github.com/MarcosGitCode/Remote-PC-Setup

