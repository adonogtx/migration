// Bluetooth adapter state. Click opens bluetui in a floating window.
import Quickshell
import Quickshell.Bluetooth
import QtQuick

BarItem {
    id: bt
    readonly property bool on: Bluetooth.defaultAdapter !== null && Bluetooth.defaultAdapter.enabled
    onClicked: Quickshell.execDetached(["gus-float", "bluetui"])
    BarIcon { name: bt.on ? "bluetooth" : "bluetooth-off" }
}
