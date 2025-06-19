#!/bin/bash

# Vérification de l'argument
if [ -z "$1" ]; then
    echo "❌ Utilisation : set-wallpaper.sh /chemin/vers/image.jpg"
    exit 1
fi

WALLPAPER="$1"

# 1. Appliquer le wallpaper via hyprpaper
# (Met à jour le fichier de conf à la volée)
echo "preload = $WALLPAPER" > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = ,$WALLPAPER" >> ~/.config/hypr/hyprpaper.conf

# Redémarre hyprpaper (ou kill s'il tourne déjà)
pkill hyprpaper
hyprpaper &

# 2. Générer une nouvelle palette (dark ou light selon ton mode actuel)
THEME_MODE=$(cat ~/.cache/theme_mode 2>/dev/null || echo "dark")

matugen image -m "$THEME_MODE" -- "$WALLPAPER"

# 3. Relancer les composants (waybar, kitty, rofi, etc.)
pkill waybar && waybar &
# si tu veux aussi recharger rofi, eww ou autre, ajoute ici :
# pkill eww && eww daemon && eww open bar

echo "✅ Wallpaper changé et thème $THEME_MODE appliqué avec matugen."
