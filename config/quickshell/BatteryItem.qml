// Battery drawn like macOS: outline, fill by charge, red when low.
import Quickshell.Services.UPower
import QtQuick

BarItem {
    id: bat
    readonly property var dev: UPower.displayDevice
    readonly property real level: {
        if (!dev) return 0
        const p = dev.percentage
        return p > 1 ? p / 100 : p          // accept 0..1 or 0..100
    }
    readonly property bool charging: dev !== null && dev.state === UPowerDeviceState.Charging
    visible: dev !== null && dev.isPresent

    Item {
        width: 22; height: 11
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: shell
            width: 20; height: 11; radius: 3
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.5)
            Rectangle {
                x: 1.5; y: 1.5
                height: parent.height - 3
                width: Math.max(1.5, (parent.width - 3) * bat.level)
                radius: 1.5
                color: bat.charging ? Theme.green : (bat.level < 0.2 ? Theme.red : Theme.label)
            }
        }
        Rectangle {
            x: 20.5; y: 3.5
            width: 1.5; height: 4; radius: 0.75
            color: Qt.rgba(1, 1, 1, 0.5)
        }
    }
}
