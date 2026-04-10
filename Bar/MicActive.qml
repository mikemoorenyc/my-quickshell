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
    
    CDIcon {
        iconName:Sound.micMuted?"mic_off":"mic"
        anchors.centerIn:parent
        iconColor:"white"
    }

    onClicked: () => {
       toggleMute.exec(["sh", "-c","pamixer --default-source -t"]) 
    }
}
