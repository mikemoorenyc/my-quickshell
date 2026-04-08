import qs.util

 import Quickshell.Io 
SettingsButton {
    iconS:Network.iconName
    backgroundFill:Network.vpn || !Network.connected
    buttonColor: {
        if(Network.vpn) {
            return Theme.colorYellowDim
        }
        if(!Network.connected) {
            return Theme.colorRedDim
        }
        return ""
    }
    buttonColorHover: {
        if(Network.vpn) {
            return Theme.colorYellowBG
        }
        if(!Network.connected) {
            return Theme.colorRedBG
        }
        return ""
    }
    borderColor: {
        if(Network.vpn) {
            return Theme.colorYellowBG
        }
        if(!Network.connected) {
            return Theme.colorRedBG
        }
        return ""
    }
    nText : Network.ssid
    Process {
        id:openBlueTooth
    }
    onClicked: () => {
        openBlueTooth.exec(["sh", "-c","omarchy-launch-wifi"])
        ShellContext.openWindow=""
        ShellContext.trayButton=null
    }
}