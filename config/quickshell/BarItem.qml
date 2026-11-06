// One clickable slot in the bar: padding, hover pill, click and wheel.
import QtQuick

Item {
    id: item
    default property alias content: row.data
    signal clicked()
    signal wheeled(real delta)

    implicitWidth: row.implicitWidth + Theme.itemPad * 2
    implicitHeight: Theme.barHeight - 6

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusItem
        color: Theme.hover
        opacity: mouse.containsMouse ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: Theme.fast } }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 6
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: item.clicked()
        onWheel: (wheel) => item.wheeled(wheel.angleDelta.y)
    }
}
