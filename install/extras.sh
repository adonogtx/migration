#!/usr/bin/env bash
# about: off by default: Plymouth boot splash (manual steps after install)
source "$(dirname "$0")/lib.sh"

pac plymouth
warn "Plymouth needs edits to mkinitcpio and your boot entry; see docs/post-install.md (Extras)."
