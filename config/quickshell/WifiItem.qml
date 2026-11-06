// Wi-Fi state from NetworkManager, polled every 10 s. Click opens nmtui.
// Commands are argument lists, never shell strings (SSIDs are untrusted text).
import Quickshell
import Quickshell.Io
import QtQuick

BarItem {
    id: wifi
    property bool connected: false
    onClicked: Quickshell.execDetached(["gus-float", "nmtui"])

    BarIcon { name: wifi.connected ? "wifi" : "wifi-off" }

    Process {
        id: poll
        command: ["nmcli", "-t", "-f", "TYPE,STATE", "device"]
        stdout: StdioCollector {
            id: out
            onStreamFinished: wifi.connected = out.text.split("\n").some(l => l === "wifi:connected")
        }
    }
    Timer { interval: 10000; running: true; repeat: true; triggeredOnStart: true; onTriggered: poll.running = true }
}
