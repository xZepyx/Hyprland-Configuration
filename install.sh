#!/bin/bash

# -------------------------------------
# 🧰 Installing Essential Packages
# -------------------------------------
echo "📦 Installing core packages with pacman..."
sudo pacman -S --noconfirm \
    kitty hyprland mako nautilus swww spotify discord \
    grim slurp neovim fastfetch gedit obs-studio \
    ranger rofi waybar starship cava fish base-devel

# -------------------------------------
# ⬇️ Cloning & Installing paru AUR Helper
# -------------------------------------
echo "🔧 Installing paru AUR helper..."
git clone https://github.com/Morganamilo/paru.git && \
cd paru && \
makepkg -si --noconfirm && \
cd ..

# -------------------------------------
# 🎨 Setting Up Hyprland Configuration
# -------------------------------------
echo "🛠️ Cloning and copying Hyprland configuration..."
git clone https://github.com/Adityavihaan/Hyprland-Configuration && \
mkdir -p ~/.config && \
cp -r Hyprland-Configuration/config* ~/.config/

# -------------------------------------
# ✅ Done
# -------------------------------------
echo "✅ Installation and setup complete!"
