import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Bar



BarButtonContainer {
    toolTipText:"Open quick tools"
    id:quickSettingsButton
    click: () => {
        if(ShellContext.openWindow == "QUICKSETTINGS_WINDOW") {
            ShellContext.trayButton = null
        ShellContext.openWindow = ""
        return 
        }
        ShellContext.trayButton = quickSettingsButton
        ShellContext.openWindow = "QUICKSETTINGS_WINDOW"
        ShellContext.trayButtonX = quickSettingsButton.x
        ShellContext.trayButtonW = quickSettingsButton.implicitWidth
    }
    isActive: ShellContext.openWindow == "QUICKSETTINGS_WINDOW"
    onImplicitWidthChanged: {
       if(isActive) {
        ShellContext.trayButtonW = quickSettingsButton.implicitWidth
       }
    }
    onXChanged : {
      
        if(isActive) {
            ShellContext.trayButtonX = quickSettingsButton.x
        }
    }
    
    //isActive:true
    
    property var muted :""
    RowLayout {
        id:container
        spacing: theme.marginButton / 2
        anchors {
    
            horizontalCenter:parent.horizontalCenter
            verticalCenter:parent.verticalCenter
        }
        SVGIcon {
            visible: Bluetooth.isConnected
            iconColor: Theme.colorBlue
            iconName:"bluetooth"
        }
        SVGIcon {
            iconColor:Network.vpn ? Theme.colorYellow:Theme.colorFG
            iconName:Network.iconName
        }
          
        
        SVGIcon {
            iconName:Sound.speakerIcon
        }
        
    
    }
    
    

    



}



