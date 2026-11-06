// Spotlight. v1 opens fuzzel; the Quickshell launcher replaces it later.
import Quickshell
import QtQuick

BarItem {
    onClicked: Quickshell.execDetached(["fuzzel"])
    BarIcon { name: "search" }
}
