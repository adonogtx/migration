#!/usr/bin/env bash
# about: Hyprland, Quickshell, lock, idle, login, portals, screenshots, clipboard
source "$(dirname "$0")/lib.sh"

compositor=(hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent qt5-wayland qt6-wayland)
shell=(quickshell qt6-svg)
session=(hyprlock hypridle hyprsunset greetd greetd-tuigreet)
launcher_and_notifications=(fuzzel mako libnotify)
wallpaper=(swaybg)
capture=(grim slurp wf-recorder)
clipboard=(wl-clipboard cliphist)
hardware_keys=(brightnessctl playerctl)
files=(nautilus gvfs gvfs-mtp file-roller)

pac "${compositor[@]}" "${shell[@]}" "${session[@]}" "${launcher_and_notifications[@]}" \
    "${wallpaper[@]}" "${capture[@]}" "${clipboard[@]}" "${hardware_keys[@]}" "${files[@]}"

# Small TUIs opened by the bar in a floating window. yay finds them in the
# official repos or the AUR, wherever they live today.
aur wiremix bluetui

info "greetd is installed but not enabled."
info "copy config/greetd/config.toml to /etc/greetd/ first, then: sudo systemctl enable greetd"
