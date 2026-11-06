// 11月5日(木)  18:57
import Quickshell
import QtQuick

BarItem {
    id: date
    readonly property var weekdays: ["日", "月", "火", "水", "木", "金", "土"]

    SystemClock { id: clock; precision: SystemClock.Minutes }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: (clock.date.getMonth() + 1) + "月" + clock.date.getDate() + "日("
              + date.weekdays[clock.date.getDay()] + ")  " + Qt.formatTime(clock.date, "HH:mm")
        font.family: Theme.jp
        font.pixelSize: Theme.body
        font.weight: Font.Medium
        color: Theme.label
    }
}
