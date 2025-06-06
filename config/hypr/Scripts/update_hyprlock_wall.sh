#!/bin/bash

# Get current swww wallpaper path
wallpath=$(swww query | grep -oP 'image: \K.*')

# Replace the path line in hyprlock.conf
sed -i "s|^ *path = .*|    path = $wallpath|" ~/.config/hypr/hyprlock.conf
