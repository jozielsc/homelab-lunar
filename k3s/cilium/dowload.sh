#!/bin/bash
set -euo pipefail

# Detectar arquitetura
ARCH=amd64
if [[ "$(uname -m)" == "aarch64" ]]; then
  ARCH=arm64
fi

# ===============================
# Baixar Cilium CLI
# ===============================
echo "Baixando a versão estável do Cilium CLI..."
CILIUM_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_TAR="cilium-linux-${ARCH}.tar.gz"

curl -L --fail -o "$CLI_TAR" \
  "https://github.com/cilium/cilium-cli/releases/download/${CILIUM_VERSION}/cilium-linux-${ARCH}.tar.gz"

# ===============================
# Instalar Cilium CLI
# ===============================
echo "Instalando Cilium CLI..."
sudo tar xzvf "$CLI_TAR" -C /usr/local/bin
rm "$CLI_TAR"

# Verifica instalação
if ! command -v cilium &>/dev/null; then
  echo "ERRO: Cilium CLI não instalado corretamente"
  exit 1
fi
echo "Cilium CLI instalado com sucesso: $(cilium version --client)"

