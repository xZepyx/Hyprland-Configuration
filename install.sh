#!/bin/bash

set -e

## -------------------------------------
## Helper Functions
## -------------------------------------
ask_continue() {
    echo
    read -rp "[?] Do you want to continue? (y/n): " ans
    [[ "$ans" != "y" ]] && echo "[!] Exiting..." && exit 1
}

error_handler() {
    echo "[✗] Error occurred during: $1"
    ask_continue
}

info() {
    echo -e "\n[→] $1"
}

success() {
    echo -e "[✓] $1"
}

## -------------------------------------
## ASUS Laptop Detection
## -------------------------------------
info "Checking if this is an ASUS laptop..."
if grep -qi asus /sys/class/dmi/id/sys_vendor; then
    echo "[!] ASUS laptop detected."
    read -rp "Do you want to install ASUS-related packages? (y/n): " asus_reply
    if [[ "$asus_reply" == "y" ]]; then
        sudo pacman -S --needed --noconfirm asusctl rog-control-center supergfxctl || error_handler "ASUS tools installation"
        sudo systemctl enable --now asusd || error_handler "Enabling asusd service"
        success "ASUS tools installed and enabled"
    fi
else
    echo "[✓] Not an ASUS laptop or vendor not detected."
fi

## -------------------------------------
## Install Core Packages
## -------------------------------------
info "Installing essential system packages..."
sudo pacman -S --needed --noconfirm \
    base-devel git \
    kitty hyprland mako nautilus swww spotify discord \
    grim slurp neovim fastfetch gedit obs-studio \
    ranger rofi waybar starship cava fish || error_handler "Core package installation"
success "Core packages installed"

## -------------------------------------
## Install paru (AUR Helper)
## -------------------------------------
info "Installing paru AUR helper..."
cd ~
if [[ ! -d paru ]]; then
    git clone https://aur.archlinux.org/paru.git || error_handler "Cloning paru"
fi
cd paru
makepkg -si --noconfirm || error_handler "Building paru"
cd ..
success "paru installed"

## -------------------------------------
## Clone Hyprland Config
## -------------------------------------
info "Cloning Hyprland config..."
if git clone https://github.com/Adityavihaan/Hyprland-Configuration; then
    mkdir -p ~/.config
    cp -r Hyprland-Configuration/config* ~/.config/ || error_handler "Copying Hyprland config"
    success "Hyprland config copied"
else
    error_handler "Cloning Hyprland-Configuration"
fi

## -------------------------------------
## Clone Wallpapers
## -------------------------------------
info "Cloning wallpapers..."
if git clone https://github.com/Adityavihaan/WallBank.git; then
    mkdir -p ~/Wallpapers
    cp -r WallBank/* ~/Wallpapers/ || error_handler "Copying wallpapers"
    success "Wallpapers installed"
else
    error_handler "Cloning WallBank"
fi

## -------------------------------------
## Done
## -------------------------------------
echo
success "Installation and setup complete!"
