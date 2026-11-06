#!/usr/bin/env bash
# about: IBM Plex (Sans, Sans JP, Serif, Mono), PlemolJP, CJK and symbol fonts
source "$(dirname "$0")/lib.sh"

plex=(ttf-ibm-plex)                       # includes IBM Plex Sans JP
cjk=(noto-fonts noto-fonts-cjk)
symbols=(ttf-nerd-fonts-symbols-mono)
pac "${plex[@]}" "${cjk[@]}" "${symbols[@]}"

aur ttf-plemoljp-bin                      # Takuya's terminal font: Plex Mono + Plex Sans JP

# Your own kamon font, if you put it in assets/fonts/.
repo="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -f $repo/assets/fonts/gus.ttf ]]; then
  install -Dm644 "$repo/assets/fonts/gus.ttf" ~/.local/share/fonts/gus.ttf
  info "installed gus.ttf (kamon glyph U+E900)"
else
  warn "assets/fonts/gus.ttf not found: the bar will draw a plain circle instead of the kamon"
fi
fc-cache -f
