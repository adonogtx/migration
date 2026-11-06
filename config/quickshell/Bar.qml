// The menu bar: kamon and workspaces on the left, status on the right.
import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar
    required property var modelData
    screen: modelData

    anchors { top: true; left: true; right: true }
    implicitHeight: Theme.barHeight
    color: Theme.bar

    Rectangle {
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: 1
        color: Theme.hairline
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Theme.edge
        anchors.rightMargin: Theme.edge
        spacing: Theme.itemGap

        Kamon {}
        Item { implicitWidth: 10 }
        Workspaces {}

        Item { Layout.fillWidth: true }

        InputSeal {}
        BluetoothItem {}
        WifiItem {}
        SoundItem {}
        BatteryItem {}
        SearchItem {}
        DateItem {}
    }
}
