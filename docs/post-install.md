# Post install

The order that keeps problems isolated. Do one step, reboot or log in, check, then go on.

## 1. Fresh Arch

Install with `archinstall`:

| Option | Choice | Why |
|---|---|---|
| Disk | btrfs, default subvolumes (`@`, `@home`, `@log`, `@pkg`, `@.snapshots`) | snapshots in step 2 expect this layout |
| Encryption | **LUKS, on** | a stolen laptop is otherwise an open book |
| Network | NetworkManager | the bar and `nmtui` talk to it |
| Audio | PipeWire | `pipewire-pulse` conflicts with PulseAudio and `--noconfirm` would stop there |
| Profile | minimal, no desktop | everything else comes from this repo |
| User | yours, with sudo | the scripts refuse to run as root |

## 2. Snapshots, before anything else

```bash
./install.sh base system
findmnt /.snapshots     # must show the @.snapshots subvolume; if it prints nothing, stop here
# archinstall already made an @.snapshots subvolume; snapper wants to create its own.
sudo umount /.snapshots
sudo rm -r /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots   # drop snapper's nested one, keep @snapshots
sudo mkdir /.snapshots
sudo mount -a
sudo chmod 750 /.snapshots
sudo snapper -c root create -d "clean install"
```

From now on `snap-pac` takes a snapshot before and after every pacman transaction. To boot into one, add `grub-btrfs` (GRUB) or `limine-snapper-sync` (Limine) depending on your bootloader.

`snapper rollback` does not work as is with the archinstall layout, because fstab mounts `@` by name. Restore by booting a snapshot from the boot menu (the tools above) or by hand from a live USB: rename `@` to `@broken`, then `btrfs subvolume snapshot` the good snapshot as the new `@`.

## 3. Desktop

```bash
./install.sh desktop fonts icons japanese terminal
cp -r config/hypr config/quickshell config/ghostty config/fuzzel config/mako config/fcitx5 \
      config/fontconfig config/gtk-3.0 config/gtk-4.0 ~/.config/
cp config/xdg/user-dirs.dirs config/xdg/user-dirs.conf config/xdg/mimeapps.list ~/.config/
cp config/zsh/.zshrc ~/
mkdir -p ~/.config/git && cp config/git/* ~/.config/git/
install -m755 config/bin/* ~/.local/bin/
cp assets/wallpapers/dark-solid.png ~/.local/share/wallpapers/

gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface icon-theme WhiteSur-dark
gsettings set org.gnome.desktop.interface cursor-theme macOS
gsettings set org.gnome.desktop.interface font-name 'IBM Plex Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'PlemolJP Console NF 11'
```

Login:

```bash
sudo cp config/greetd/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd
```

Reboot. Keep `Ctrl + Alt + F2` in mind: a text login always works there.

Check, in this order:

1. `hyprctl configerrors` prints nothing. A broken module shows a red notification and the others still load.
2. Super + Return opens Ghostty. This bind is first in `binds.lua` so you always have a terminal.
3. **Test the lock before you trust it:** run `hyprlock` from Ghostty, unlock, then try a wrong password once. If hyprlock fails to start, idle and suspend will not lock the screen.
4. The bar shows five dots, Ctrl + Space shows あ in it.

## 4. Work

```bash
./install.sh backend editors
cp -r config/doom ~/.config/
cp -r org ~/                       # starter org files, only on a new machine
~/.config/emacs/bin/doom install
cp config/intellij/idea64.vmoptions ~/.config/JetBrains/<IdeaVersion>/
```

Log out and back in once so the docker group applies.

Docker publishes ports around ufw: `-p 5432:5432` is reachable from the whole Wi-Fi network even with the firewall on. Always bind to localhost:

```yaml
ports:
  - "127.0.0.1:5432:5432"
```

## PostgreSQL

The cluster is created with `peer` for local sockets and passwords for TCP, so create your role once:

```bash
sudo -iu postgres createuser --createdb --pwprompt "$USER"
```

Spring connects with that user and password on `localhost:5432`.

Major versions (17 to 18, say) need `pg_upgrade`. When `pacman -Syu` lists a new major `postgresql`, follow the ArchWiki PostgreSQL upgrade section before rebooting. For study projects, a pinned `postgres:17` in Docker bound to 127.0.0.1 avoids this entirely.

## 5. Apps

```bash
./install.sh apps
cp -r config/mpv config/mpd config/zathura ~/.config/
systemctl --user start mpd mpd-mpris
```

## If something breaks

| Symptom | Fix |
|---|---|
| Black screen after login | Ctrl + Alt + F2, log in, read `hyprctl configerrors` or `~/.local/share/hyprland/hyprland.log` |
| Lock screen shows a crash message | Ctrl + Alt + F3, log in as yourself, run `WAYLAND_DISPLAY=wayland-1 hyprlock`, then go back with Ctrl + Alt + F1 |
| Bar is gone | `quickshell` from a terminal shows the QML error |
| Workspace dots do not switch on click | Your Hyprland may still accept the old dispatcher text: change the line in `Workspaces.qml` to `Hyprland.dispatch("workspace " + parent.wsId)` |
| An update broke the system | Boot the previous snapshot from the boot menu, or restore `@` by hand (step 2) |

## Extras

Off by default. Plymouth: `./install.sh extras`, add `plymouth` to `HOOKS` in `/etc/mkinitcpio.conf` after `systemd`, run `sudo mkinitcpio -P`, and add `quiet splash` to your kernel parameters. Autologin: add an `[initial_session]` block to `/etc/greetd/config.toml` with `command = "start-hyprland"` and `user = "<you>"`; hyprlock then protects the session. Google Calendar: uncomment `org-gcal` in `config/doom/packages.el`.
