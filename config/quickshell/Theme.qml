// Dark Solid tokens. Real pixels; the deck draws them at 2x.
// Same values as hypr/modules/theme.lua, ghostty, mako and fuzzel.
pragma Singleton
import Quickshell
import QtQuick

Singleton {
    // Surfaces
    readonly property color bar: "#161618"
    readonly property color panel: "#1f1f21"
    readonly property color tile: "#2a2a2d"
    readonly property color line: "#38383a"
    readonly property color hairline: Qt.rgba(1, 1, 1, 0.06)
    readonly property color hover: Qt.rgba(1, 1, 1, 0.14)

    // Text
    readonly property color label: "#f5f5f7"
    readonly property color secondary: "#98989d"
    readonly property color tertiary: "#636366"

    // Meaning
    readonly property color accent: "#0a84ff"
    readonly property color green: "#30d158"
    readonly property color red: "#ff453a"

    // Type
    readonly property string sans: "IBM Plex Sans"
    readonly property string jp: "IBM Plex Sans JP"
    readonly property int body: 13
    readonly property int detail: 12

    // Grid
    readonly property int barHeight: 28
    readonly property int icon: 14
    readonly property int itemPad: 5      // horizontal padding inside a bar item
    readonly property int itemGap: 2      // space between bar items
    readonly property int edge: 12        // bar padding at the screen edges
    readonly property int radiusItem: 5
    readonly property int fast: 150       // ms, every animation
}
