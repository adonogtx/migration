-- Apps launched from binds and autostart. Change them here only.
return {
  terminal = "ghostty",
  browser  = "brave",
  files    = "nautilus --new-window",
  editor   = "emacsclient -c -a ''",     -- starts the daemon on first use, inside Hyprland
  ide      = "intellij-idea-oss",
  launcher = "fuzzel",
  float    = "gus-float",              -- opens a TUI in a floating Ghostty
}
