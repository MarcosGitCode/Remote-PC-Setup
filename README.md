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

## 🔒 O Papel do Tailscale na Arquitetura
O principal desafio em conexões residenciais modernas é o **CGNAT (Carrier-Grade NAT)**, que impede o redirecionamento de portas tradicional (Port Forwarding) e oculta o IP público real da residência. 

O Tailscale resolve essa limitação atuando como uma camada de rede virtual privada (VPN Mesh):
* **Bypass de CGNAT:** Ele estabelece conexões diretas ponto a ponto (Peer-to-Peer) entre o cliente e o servidor de borda, utilizando técnicas de NAT Traversal.
* **Segurança Baseada em WireGuard:** Todo o tráfego que passa pelo túnel é criptografado nativamente utilizando o protocolo WireGuard, garantindo que a sessão SSH fique invisível para a internet pública.
* **Roteamento Estático Simplificado:** Cada dispositivo recebe um endereço IP fixo dentro do range da rede virtual, eliminando a necessidade de configurar serviços complexos de DNS Dinâmico (DDNS).

## ⚙️ Como Replicar

### Passo 1: Preparação do Computador Destino (PC que será ligado)
1. Acesse a **BIOS/UEFI** do computador que você deseja ligar remotamente.
2. Ative a opção **Wake-on-LAN (WoL)** (geralmente encontrada em *Power Management* ou *Advanced / Onboard Ports* como "Wake on Magic Packet", "PCIE Devices Power On" ou similar).
3. No sistema operacional do computador, vá até as propriedades da placa de rede de internet (via cabo) e certifique-se de que a opção "Permitir que este dispositivo acorde o computador" esteja ativa.
4. Anote o **Endereço MAC** da placa de rede com fio do computador.

### Passo 2: Configuração do Servidor de Borda (Android/Termux ou PC Linux Velho)
1. Instale o ambiente de terminal (App **Termux** no Android ou acesse o terminal nativo da sua distribuição Linux legada).
2. Certifique-se de que o dispositivo servidor esteja conectado na **mesma rede local (Wi-Fi ou cabo)** que o computador destino.
3. No terminal do servidor, clone este repositório e acesse a pasta:
   ```bash
   git clone [https://github.com/MarcosGitCode/Remote-PC-Setup](https://github.com/MarcosGitCode/Remote-PC-Setup)
   cd Remote-PC-Setup

