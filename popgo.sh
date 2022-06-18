#!/bin/bash

GO_VERSION="1.18.3"
GO_PATH="/root/go"

# Reset
Color_Off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


declare -a GETS=(
github.com/driftsec/lstcmp
github.com/driftsec/urlencode
github.com/driftsec/urltree
github.com/driftsec/httprobex
github.com/driftsec/pnmap
github.com/driftsec/pffuf
github.com/driftsec/goserver
github.com/driftsec/replay
github.com/tomnomnom/meg
github.com/tomnomnom/anew
github.com/tomnomnom/unfurl
github.com/tomnomnom/httprobe
github.com/tomnomnom/qsreplace
github.com/tomnomnom/gron
github.com/tomnomnom/waybackurls
github.com/tomnomnom/gf
github.com/tomnomnom/comb
github.com/tomnomnom/fff
github.com/lc/gau
github.com/glebarez/cero
github.com/jaeles-project/gospider
github.com/hakluke/hakrawler
github.com/jpillora/chisel
github.com/ffuf/ffuf
github.com/bp0lr/gauplus
github.com/rverton/webanalyze/cmd/webanalyze
github.com/sensepost/gowitness
dw1.io/go-dork
github.com/projectdiscovery/httpx/cmd/httpx
github.com/projectdiscovery/interactsh/cmd/interactsh-client
github.com/projectdiscovery/nuclei/v2/cmd/nuclei
github.com/projectdiscovery/subfinder/v2/cmd/subfinder
github.com/projectdiscovery/shuffledns/cmd/shuffledns
github.com/lc/subjs
github.com/signedsecurity/sigurlfind3r/cmd/sigurlfind3r
)

if ! [ -x "$(command -v gcc)" ]; then
    echo "$Red[-] gcc not found!$Color_Off"
    echo "$Yellow[+] Installing gcc ...$Color_Off"
    sudo apt update
    sudo apt install build-essential
fi

if ! [ -x "$(command -v go)" ]; then
    echo "$Red[-] go not found!$Color_Off"
    echo "$Yellow[+] Installing Go version ${GO_VERSION} ...$Color_Off"
    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go${GO_VERSION}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf /tmp/go${GO_VERSION}.linux-amd64.tar.gz 
    mkdir -p "${GO_PATH}"
    export GOROOT=/usr/local/go/
    export GOPATH="${GO_PATH}"
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH    
    echo "export GOROOT=/usr/local/go/" >> ${HOME}/.bashrc
    echo "export GOPATH=${GOPATH}" >> ${HOME}/.bashrc
    echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ${HOME}/.bashrc
    source ${HOME}/.bashrc
    sleep 1  
fi

# GO111MODULE=auto
for var in "${GETS[@]}"; do
  echo "$Yellow[+] Installing ${var}$Color_Off"
  go install ${var}@latest
done
