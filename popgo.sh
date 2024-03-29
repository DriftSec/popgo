#!/bin/bash

# if a GOPATH is not specified wiwth $1, you will be prompted for it.
# ARG_GO_PATH="${1}"

# set -e
GO_VERSION_DEFAULT="1.19.3"
GO_PATH_DEFAULT="$HOME/go"



Color_Off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


exit_on_error() {
    echo -e "$Red[ERROR] ${1} command failed.$Color_Off"
    exit 1
}


declare -a GETS=(

github.com/DriftSec/lstcmp
github.com/DriftSec/urlencode
github.com/DriftSec/urltree
github.com/DriftSec/httprobex
github.com/DriftSec/pnmap
github.com/DriftSec/pffuf
github.com/DriftSec/goserver
github.com/DriftSec/replay
github.com/DriftSec/resolve
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
    echo -e "$Red[-] gcc not found!$Color_Off"
    echo -e "$Yellow[+] Installing gcc ...$Color_Off"
    sudo apt update
    sudo apt install build-essential
fi
echo -e "$Green[+] gcc is isntalled$Color_Off"

if ! [ -x "$(command -v go)" ]; then
    echo -e "$Red[-] Go not found!$Color_Off"

    echo -e "$Blue[!] Finding latest version of Go for Linux amd64...$Color_Off"
    url="$(wget -qO- https://go.dev/dl/ | grep -oP '/dl/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )"
    GO_VERSION="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"
    GO_VERSION=${GO_VERSION:-$GO_VERSION_DEFAULT}
    echo -e "$Yellow[+] Installing Go version ${GO_VERSION} ...$Color_Off"

    echo -e "\n"

    # GO_PATH="${ARG_GO_PATH}"
    # if [ -z ARG_GO_PATH="${1}" ]; then 
    #     read -p "Where do want GOPATH to be? [\$HOME/go]> " GO_PATH
        GO_PATH=${GO_PATH:-$GO_PATH_DEFAULT}
    # fi
    
    echo -e "$Blue[!] GOPATH will be: $GO_PATH$Color_Off"

    wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go${GO_VERSION}.linux-amd64.tar.gz || exit_on_error "wget"

    sudo tar -C /usr/local -xzf /tmp/go${GO_VERSION}.linux-amd64.tar.gz || exit_on_error "tar"

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
echo -e "$Green[+] Go is installed$Color_Off"

# GO111MODULE=auto

if [ -z "${JUST_GO}" ]; then
    for var in "${GETS[@]}"; do
    echo -e "$Yellow[+] Installing ${var}$Color_Off"
    go install ${var}@latest || echo -e "$Red[ERROR] failed to isntall ${var}$Color_Off"
    done
else 
    echo -e "$Blue[!] JUST_GO is set, skipping module install.$Color_Off" 


fi
echo -e "$Green[+] Finished.$Color_Off"     