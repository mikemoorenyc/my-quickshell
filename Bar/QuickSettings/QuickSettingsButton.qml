import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Bar



BarButtonContainer {

    id:quickSettingsButton
    click: () => {
        ShellContext.trayButton = quickSettingsButton
        ShellContext.openWindow = "QUICKSETTINGS_WINDOW"
    }
    isActive: ShellContext.openWindow == "QUICKSETTINGS_WINDOW"
    property var muted :""
    RowLayout {
        id:container
        spacing: theme.marginButton / 2
        anchors {
    
            horizontalCenter:parent.horizontalCenter
            verticalCenter:parent.verticalCenter
        }
        CDIcon {
            visible: Bluetooth.isConnected
            iconColor: Theme.colorBlue
            iconName:"bluetooth"
        }
        CDIcon {
            iconColor:Network.vpn ? Theme.colorYellow:Theme.colorFG
            iconName:Network.iconName
        }
          
        
        CDIcon {
            iconName:Sound.speakerIcon
        }
        
        
    }
    Component.onCompleted: {
        ShellContext.trayButton = quickSettingsButton
    }
    

    



}



