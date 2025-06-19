#!/bin/bash

choice=$(echo -e "⏻ Poweroff\n Reboot\n󰗽 Logout" | rofi -dmenu -p "Power Menu")

case "$choice" in
  *Poweroff) poweroff ;;
  *Reboot) reboot ;;
  *Logout) hyprctl dispatch exit ;;
esac
