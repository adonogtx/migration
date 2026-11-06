# dotfiles

Gus's Arch Linux + Hyprland setup: a macOS like desktop in Dark Solid (no translucency), set in IBM Plex, with Doom Emacs for notes and IntelliJ for Java.

Two rules keep it simple:

1. **Scripts install packages, nothing else.** One module per category, with its packages listed inside it.
2. **Configs are copied by hand.** One folder per program under `config/`. No symlinks, no sync tool.

## Structure

```
dotfiles/
├── install.sh                 entry point: ./install.sh <module>... | all
├── install/                   one script per category, packages inside
│   ├── lib.sh                 shared helpers (pac, aur, enable, logging)
│   ├── base.sh                build tools, git, yay, home folders
│   ├── system.sh              network, audio, bluetooth, power, firewall, snapshots, Intel GPU
│   ├── desktop.sh             Hyprland, Quickshell, hyprlock, hypridle, greetd, portals, capture
│   ├── fonts.sh               IBM Plex, PlemolJP, CJK, symbols, your gus.ttf
│   ├── icons.sh               WhiteSur icons, macOS cursor, Adwaita dark
│   ├── japanese.sh            fcitx5 + Mozc
│   ├── terminal.sh            Ghostty, zsh + oh my zsh, CLI tools
│   ├── backend.sh             sdkman (Java, Maven, Gradle), Docker, PostgreSQL, DBeaver, IntelliJ, Bruno, exercism
│   ├── editors.sh             Emacs (Wayland) and Doom
│   ├── apps.sh                Brave, zathura, mpv + uosc, mpd + rmpc, imv, Anki, Bitwarden, Discord
│   └── extras.sh              off by default: Plymouth
├── config/                    one folder per program, copy what you want
│   ├── hypr/                  hyprland.lua + modules/ (monitors, env, look, input, rules, binds, autostart), hyprlock, hypridle
│   ├── quickshell/            the menu bar: Theme.qml, Bar.qml, one file per bar item, icons/
│   ├── ghostty/               config + themes/dark-solid
│   ├── zsh/                   .zshrc
│   ├── git/                   config, global ignore
│   ├── doom/                  init.el, config.el, packages.el
│   ├── fcitx5/                Ctrl + Space, Mozc profile
│   ├── fuzzel/  mako/         launcher and banners until Quickshell takes over
│   ├── mpv/  mpd/  rmpc/  zathura/
│   ├── gtk-3.0/  gtk-4.0/  fontconfig/  xdg/
│   ├── greetd/                /etc/greetd/config.toml (system file)
│   ├── intellij/              Wayland VM option and notes
│   └── bin/                   gus-screenshot, gus-record, gus-nightlight, gus-float, gus-jdate
├── assets/
│   ├── wallpapers/            dark-solid.png
│   └── fonts/                 put gus.ttf here (kamon, U+E900)
├── org/                       starter todo, lists, career, help
└── docs/
    ├── post-install.md        step by step from a fresh archinstall, plus fixes
    ├── risks.md               what can break, what is not safe, what the repo does about it
    ├── keybindings.md
    └── theme.md               every token and where it lives
```

## Install

```bash
git clone git@github.com:adonogtx/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh            # lists the modules
./install.sh base system
```

Then follow `docs/post-install.md`: snapshots first, desktop second, work tools third, apps last. Each step ends with a check.

AUR packages go through yay, which shows each PKGBUILD and asks before building. Read them.

## Configs

| Folder | Copy to |
|---|---|
| `config/<program>/` | `~/.config/<program>/` |
| `config/zsh/.zshrc` | `~/.zshrc` |
| `config/xdg/*` | `~/.config/` |
| `config/bin/*` | `~/.local/bin/` (`install -m755`) |
| `config/greetd/config.toml` | `/etc/greetd/config.toml` (sudo) |
| `config/intellij/idea64.vmoptions` | `~/.config/JetBrains/<IdeaVersion>/` |

## Security choices

| Choice | Why |
|---|---|
| Lock screen is hyprlock for now | Maintained by the Hyprland team and widely tested. The Quickshell lock from the deck comes after the rest is stable. |
| `allow_session_lock_restore` on | If the lock crashes, the session stays locked and you can restart the lock from a TTY. |
| Bar runs commands as argument lists | Wi-Fi and Bluetooth names are text from strangers; they never reach a shell. |
| mpd listens on 127.0.0.1 only | Nobody on the network controls your player. |
| ufw: deny incoming | Nothing is reachable from outside unless you open it. |
| docker group warning | Being in it is the same as root; the script says so before adding you. |
| No hyprbars plugin | Plugins break on every Hyprland update. Windows go without title buttons, like most tiling setups. |
| Clipboard history capped at 50 | Copied passwords stay in it; Super + Shift + C wipes it. |
| PostgreSQL with peer and scram | initdb's default would let any local user in as superuser. |
| LUKS required in the docs | The only protection if the laptop is stolen. |

Full list: `docs/risks.md`.

## Roadmap

v1 is this repo: the bar, the lock, the login, every app configured.

Next, each as new files in `config/quickshell/`: Wi-Fi, Bluetooth, Sound and Battery menus, Control Center, Notification Center with the Japanese calendar (replaces mako), Spotlight (replaces fuzzel), the Quickshell greeter, then the Quickshell lock.

## Notes

Hyprland 0.57 removed the old `hyprland.conf` format, so the config is Lua. hyprlock and hypridle still use their own `.conf` files. If a Hyprland update renames a dispatcher, `hyprctl configerrors` names the line.
