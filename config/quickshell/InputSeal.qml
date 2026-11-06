// あ seal: filled while Mozc is active, outlined A otherwise. Click toggles.
import Quickshell
import Quickshell.Io
import QtQuick

BarItem {
    id: seal
    property bool japanese: false

    onClicked: {
        Quickshell.execDetached(["fcitx5-remote", "-t"])
        poll.running = true
    }

    Rectangle {
        width: 14; height: 14; radius: 3.5
        color: seal.japanese ? Theme.label : "transparent"
        border.width: seal.japanese ? 0 : 1.2
        border.color: Theme.label
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.centerIn: parent
            text: seal.japanese ? "あ" : "A"
            font.family: Theme.jp
            font.pixelSize: 9
            font.weight: Font.DemiBold
            color: seal.japanese ? Theme.bar : Theme.label
        }
    }

    // fcitx5-remote prints 2 when an input method (Mozc) is active.
    Process {
        id: poll
        command: ["fcitx5-remote"]
        stdout: StdioCollector { id: out; onStreamFinished: seal.japanese = out.text.trim() === "2" }
    }
    Timer { interval: 1000; running: true; repeat: true; triggeredOnStart: true; onTriggered: poll.running = true }
}
