#!/bin/bash

# Exit script on any error
set -e

# Function to check if a package is installed, and install it if necessary
install_if_needed() {
    if ! dpkg -l | grep -q "^ii  $1"; then
        echo "Installing $1..."
        sudo apt-get install -y $1
    else
        echo "$1 is already installed."
    fi
}

# Function to check if a Go tool is installed
install_go_tool() {
    if ! command -v $(basename $1) &> /dev/null; then
        echo "Installing Go tool: $1"
        go install -v "$1"
    else
        echo "$(basename $1) is already installed."
    fi
}

# Function to check if a Python package is installed
install_python_tool() {
    if ! pip3 show $1 &> /dev/null; then
        echo "Installing Python tool: $1"
        pip3 install $1 --quiet
    else
        echo "$1 is already installed."
    fi
}

# Function to check if a Cargo package is installed
install_cargo_tool() {
    if ! cargo install --list | grep -q "$1"; then
        echo "Installing Cargo tool: $1"
        cargo install $1
    else
        echo "$1 is already installed."
    fi
}

# Update and install prerequisites
sudo apt-get update

# Install necessary packages if not already installed
install_if_needed "golang-go"
install_if_needed "python3-pip"
install_if_needed "cargo"
install_if_needed "git"
install_if_needed "libpcap-dev"  # Install libpcap development package

# Set GOPATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# List of Go tools to install
go_tools=(
    "github.com/tomnomnom/anew@latest"
    "github.com/tomnomnom/assetfinder@latest"
    "github.com/ferreiraklet/airixss@latest"
    "github.com/dwisiswant0/cf-check@latest"
    "github.com/edoardottt/cariddi/cmd/cariddi@latest"
    "github.com/lc/gau/v2/cmd/gau@latest"
    "github.com/jaeles-project/gospider@latest"
    "github.com/Emoe/kxss@latest"
    "github.com/hakluke/hakrevdns@latest"
    "github.com/hakluke/haktldextract@latest"
    "github.com/hakluke/haklistgen@latest"
    "github.com/projectdiscovery/katana/cmd/katana@latest"
    "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
    "github.com/tomnomnom/qsreplace@latest"
    "github.com/shenwei356/rush@latest"
    "github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
    "github.com/lc/subjs@latest"
    "github.com/dwisiswant0/unew@latest"
    "github.com/tomnomnom/unfurl@latest"
    "github.com/tomnomnom/waybackurls@latest"
    "github.com/detectify/page-fetch@latest"
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    "github.com/ffuf/ffuf@latest"
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
    "github.com/haccer/subjack@latest"
    "github.com/maurosoria/dirsearch@latest"
    "github.com/tomnomnom/hacks/filter-resolved@latest"
    "github.com/tomnomnom/hacks/html-tool@latest"
    "github.com/tomnomnom/hacks/anti-burl@latest"
    "github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
    "github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
    "github.com/epi052/feroxbuster@latest"
    "github.com/pwnesia/dnstwist@latest"
    "github.com/cgboal/sonarsearch/cmd/sonarsearch@latest"
    "github.com/Josue87/gotator@latest"
    "github.com/KathanP19/Gxss@latest"
    "github.com/vortexau/dnsvalidator/cmd/dnsvalidator@latest"
    "github.com/s0md3v/uro@latest"
    "github.com/0xsha/Amass/v3/cmd/amass@latest"
    "github.com/lukasikic/subzy@latest"
    "github.com/pwnesia/s0mb0t@latest"
    "github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest"
    "github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest"
    "github.com/hahwul/dalfox/v2@latest"
    "github.com/sensepost/gowitness@latest"
    "github.com/tomnomnom/gron@latest"
    "github.com/tomnomnom/hacks/anti-burl@latest"
    "github.com/codingo/Interlace@latest"
    "github.com/sensepost/ruler@latest"
    "github.com/sensepost/gowitness@latest"
    "github.com/hakluke/hakrawler@latest"
    "github.com/sensepost/gowitness@latest"
    "github.com/sensepost/ruler@latest"
)

# Install Go tools
for tool in "${go_tools[@]}"; do
    install_go_tool "$tool"
done

# Install Python tools
python_tools=(
    "bhedak"
    "arjun"
    "dalfox"
    "git-dumper"
    "sublist3r"
    "truffleHog"
    "knockpy"
    "sqlmap"
    "dirhunt"
    "fierce"
    "theHarvester"
    "search-that-hash"
    "wappalyzer"
    "subbrute"
    "xssstrike"
    "commix"
    "tplmap"
    "censys"
    "doxydox"
    "massdns"
    "nmaptocsv"
    "pydictor"
    "gobuster"
    "dirb"
    "masscan"
    "whatweb"
    "wafw00f"
    "clusterd"
    "testssl"
    "unfurl"
    "subfinder"
    "vulscan"
    "xsser"
    "ipwhois"
    "wappalyzer"
    "retire"
    "sherlock"
    "wpscan"
    "Photon"
    "recon-ng"
    "Shodan"
    "cloud_enum"
    "tko-subs"
    "ParamSpider"
)

echo "Installing Python tools..."
for tool in "${python_tools[@]}"; do
    install_python_tool "$tool"
done

# Install Cargo tools
cargo_tools=(
    "x8"
    "ripgrep"
    "hyperfine"
    "fd-find"
    "ripgrep"
    "bat"
    "sd"
    "exa"
    "delta"
    "zoxide"
    "bandwhich"
    "cargo-watch"
    "starship"
)

echo "Installing Cargo tools..."
for tool in "${cargo_tools[@]}"; do
    install_cargo_tool "$tool"
done

# Completion message
echo "Installation of bug bounty tools completed successfully."

