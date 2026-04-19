import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Io
import Quickshell.Services.Pipewire

BarButton {
    id:micActive
    backgroundColor:!Sound.micMuted?Theme.colorBlueBG:"transparent"
    backgroundColorHover:!Sound.micMuted?Theme.colorBlueBGHover:Theme.colorShell
    borderColor:Theme.colorBlueBG
    visible: activeTracker.linkGroups.length
    PwNodeLinkTracker {
        id:activeTracker
        node:Sound.defaultSource

    }
    Process {
        id:toggleMute
    }
    
    SVGIcon {
        iconName:Sound.micMuted?"microphone-mute":"microphone"
        anchors.centerIn:parent

    }

    onClicked: () => {
       toggleMute.exec(["sh", "-c","pamixer --default-source -t"]) 
    }
}
