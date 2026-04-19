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
  
    onClicked: () => {
        if(ShellContext.openWindow == "SYSTEM_TRAY") {
            ShellContext.openWindow = ""
            return 
        }
       ShellContext.trayButton = (ShellContext.openWindow) == "SYSTEM_TRAY"?null:systemTrayButton
        ShellContext.openWindow = (ShellContext.openWindow) == "SYSTEM_TRAY"?"": "SYSTEM_TRAY"
        if(isActive) {
            ShellContext.trayButtonX = systemTrayButton.x
            ShellContext.trayButtonW = systemTrayButton.implicitWidth
        }   
        
    }
    toolTipText: "System tray"
    panel:"BAR_WINDOW"
    onXChanged: {
     
        if(isActive) {
           const newX = systemTrayButton.x
    Qt.callLater(() => {
        ShellContext.trayButtonX = newX
    })
        }
    }
    onImplicitWidthChanged: {
        
        if(isActive) {
            ShellContext.trayButtonW = systemTrayButton.implicitWidth
        }
    }
    
    SVGIcon {
        iconName:chevronIcon
        anchors.centerIn:parent
    }
   

}