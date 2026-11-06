// Your kamon from gus.ttf (U+E900). Falls back to a drawn circle.
import QtQuick

Item {
    readonly property bool hasFont: Qt.fontFamilies().indexOf("gus") >= 0
    implicitWidth: Theme.icon + 2
    implicitHeight: Theme.barHeight

    Text {
        visible: parent.hasFont
        anchors.centerIn: parent
        text: ""
        font.family: "gus"
        font.pixelSize: Theme.icon + 2
        color: Theme.label
    }
    BarIcon {
        visible: !parent.hasFont
        name: "kamon"
        anchors.centerIn: parent
    }
}
