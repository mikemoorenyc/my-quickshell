import qs.util

 import Quickshell.Io 
SettingsButton {
    iconS:Network.iconName
    iconC: Network.vpn ? Theme.colorTextDark:""
    backgroundFill:Network.vpn || !Network.connected
    buttonColor: {
        if(Network.vpn) {
            return Theme.colorYellow
        }
        if(!Network.connected) {
            return Theme.colorRedBG
        }
        return ""
    }
    buttonColorHover: {
        if(Network.vpn) {
            return Theme.colorYellowBGHover
        }
        if(!Network.connected) {
            return Theme.colorRedBGHover
        }
        return ""
    }
    borderColor: {
        if(Network.vpn) {
            return Theme.colorYellowBGHover
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