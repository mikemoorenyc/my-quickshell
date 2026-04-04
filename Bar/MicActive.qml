import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Io
import Quickshell.Services.Pipewire

BarButton {
    id:micActive
    backgroundColor:!Sound.micMuted?Theme.colorBlueDim:"transparent"
    backgroundColorHover:!Sound.micMuted?Theme.colorBlue:Theme.colorShell
    borderColor:Theme.colorBlue
    visible: activeTracker.linkGroups.length
    PwNodeLinkTracker {
        id:activeTracker
        node:Sound.defaultSource

    }
    Process {
        id:toggleMute
    }
    
    CDIcon {
        iconName:Sound.micMuted?"microphone-mute":"microphone"
        anchors.centerIn:parent
    }

    click: () => {
       toggleMute.exec(["sh", "-c","pamixer --default-source -t"]) 
    }
}
