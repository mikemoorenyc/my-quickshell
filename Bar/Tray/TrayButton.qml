import QtQuick // for Text
import QtQuick.Controls
import qs.util
import qs.Bar
import Quickshell.Io
import Quickshell


BarButton {
    property string chevronIcon: ShellContext.openWindow == "SYSTEM_TRAY"?"chevron-down":"chevron-up"
    id:systemTrayButton
    isActive: ShellContext.openWindow == "SYSTEM_TRAY"
    click: () => {
       
        ShellContext.openWindow = (ShellContext.openWindow) == "SYSTEM_TRAY"?"": "SYSTEM_TRAY"
      
        ShellContext.trayButton = systemTrayButton
        
    }
    CDIcon {
        iconName:chevronIcon
        anchors.centerIn:parent
    }

}