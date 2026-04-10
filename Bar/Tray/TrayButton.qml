import QtQuick // for Text
import QtQuick.Controls
import qs.util
import qs.Bar
import Quickshell.Io
import Quickshell


BarButton {
    property string chevronIcon: ShellContext.openWindow == "SYSTEM_TRAY"?"keyboard_arrow_down":"keyboard_arrow_up"
    id:systemTrayButton
    isActive: ShellContext.openWindow == "SYSTEM_TRAY"
    onClicked: () => {
       ShellContext.trayButton = (ShellContext.openWindow) == "SYSTEM_TRAY"?null:systemTrayButton
        ShellContext.openWindow = (ShellContext.openWindow) == "SYSTEM_TRAY"?"": "SYSTEM_TRAY"
      
       
        
    }
    CDIcon {
        iconName:chevronIcon
        anchors.centerIn:parent
    }

}