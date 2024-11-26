#!/bin/bash

# Exit script on any error
set -e

# Function to check if a package is installed and install it if necessary
install_if_needed() {
    if ! dpkg -l | grep -q "^ii  $1"; then
        echo "Installing $1..."
        sudo apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Function to check if a Go tool is installed and install it if necessary
install_go_tool() {
    local tool_name
    tool_name=$(basename "$1" | cut -d@ -f1)
    if ! command -v "$tool_name" &> /dev/null; then
        echo "Installing Go tool: $tool_name"
        go install -v "$1"
    else
        echo "$tool_name is already installed."
    fi
}

# Function to check if a Python package is installed and install it if necessary
install_python_tool() {
    if ! pip3 show "$1" &> /dev/null; then
        echo "Installing Python tool: $1"
        pip3 install "$1" --quiet
    else
        echo "$1 is already installed."
    fi
}

# Function to check if a Cargo package is installed and install it if necessary
install_cargo_tool() {
    if ! cargo install --list | grep -q "^$1 "; then
        echo "Installing Cargo tool: $1"
        cargo install "$1"
    else
        echo "$1 is already installed."
    fi
}

# Update and install prerequisites
sudo apt-get update

# Install necessary packages
prerequisite_packages=(
    "golang-go"
    "python3-pip"
    "cargo"
    "git"
    "libpcap-dev"
)

echo "Installing prerequisite packages..."
for package in "${prerequisite_packages[@]}"; do
    install_if_needed "$package"
done

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
    "github.com/projectdiscovery/katana/cmd/katana@latest"
    "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
    "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    "github.com/ffuf/ffuf@latest"
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
    "github.com/projectdiscovery/httpx/cmd/httpx@latest"
    "github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest"
    "github.com/projectdiscovery/chaos-client/cmd/chaos@latest"
    "github.com/epi052/feroxbuster@latest"
    "github.com/hahwul/dalfox/v2@latest"
    "github.com/tomnomnom/qsreplace@latest"
)

echo "Installing Go tools..."
for tool in "${go_tools[@]}"; do
    install_go_tool "$tool"
done

# List of Python tools to install
python_tools=(
    "arjun"
    "dalfox"
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
    "massdns"
    "nmaptocsv"
    "wpscan"
    "cloud_enum"
    "ParamSpider"
)

echo "Installing Python tools..."
for tool in "${python_tools[@]}"; do
    install_python_tool "$tool"
done

# List of Cargo tools to install
cargo_tools=(
    "ripgrep"
    "hyperfine"
    "fd-find"
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
