// An icon from icons/, drawn at the bar size.
import QtQuick

Image {
    property string name
    source: Qt.resolvedUrl("icons/" + name + ".svg")
    width: Theme.icon
    height: Theme.icon
    sourceSize.width: Theme.icon * 2
    sourceSize.height: Theme.icon * 2
}
