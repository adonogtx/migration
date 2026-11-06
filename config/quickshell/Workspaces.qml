// Five dots. Bright: a window lives there. Faint: empty. Active: a blue pill.
import Quickshell.Hyprland
import QtQuick

Row {
    spacing: 5

    Repeater {
        model: 5

        Rectangle {
            required property int index
            readonly property int wsId: index + 1
            readonly property bool active: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === wsId
            readonly property bool occupied: Hyprland.workspaces.values.some(w => w.id === wsId)

            anchors.verticalCenter: parent.verticalCenter
            width: active ? 16 : 5
            height: 5
            radius: 2.5
            color: active ? Theme.accent : Theme.label
            opacity: active ? 1 : (occupied ? 0.55 : 0.22)

            Behavior on width { NumberAnimation { duration: Theme.fast; easing.type: Easing.OutCubic } }
            Behavior on opacity { NumberAnimation { duration: Theme.fast } }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -5
                // Hyprland 0.55+ takes Lua dispatchers over IPC.
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + parent.wsId + " })")
            }
        }
    }
}
