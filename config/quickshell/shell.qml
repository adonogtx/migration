// Gus · Quickshell entry point. One bar per screen.
// v1 ships the menu bar. Menus, Control Center, notifications and the
// launcher come next as their own files in this folder (docs/roadmap in README).
import Quickshell
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens
        Bar {}
    }
}
