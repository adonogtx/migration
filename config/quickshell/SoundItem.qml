// Default output. Scroll changes volume in 5% steps, click opens wiremix.
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

BarItem {
    id: sound
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink !== null && sink.audio !== null && sink.audio.muted

    PwObjectTracker { objects: [sound.sink] }

    onClicked: Quickshell.execDetached(["gus-float", "wiremix"])
    onWheeled: (delta) => {
        if (!sink || !sink.audio) return
        const step = delta > 0 ? 0.05 : -0.05
        sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + step))
    }

    BarIcon { name: sound.muted ? "speaker-muted" : "speaker" }
}
