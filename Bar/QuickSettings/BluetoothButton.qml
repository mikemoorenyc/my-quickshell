import qs.util

 import Quickshell.Io 
SettingsButton {
    iconS:"bluetooth"
    buttonColor:Bluetooth.isConnected?Theme.colorBlueBG:""
    buttonColorHover:Bluetooth.isConnected?Theme.colorBlueBGHover:""
    borderColor: Bluetooth.isConnected?Theme.colorBlueBG:""
    backgroundFill:Bluetooth.isConnected
    nText : {
        if(!Bluetooth.isConnected) return "Bluetooth"
        let onlineDevices = []
        
        for (var i = 0; i < Bluetooth.connectedDevices.length; i++)
            if(Bluetooth.connectedDevices[i].state === 1) {
                onlineDevices.push(Bluetooth.connectedDevices[i])
            } 
        if(onlineDevices.length>1) {
            return `${onlineDevices.length} devices`
        }
        if(onlineDevices.length<1) {
            return "Bluetooth"
        }
        return onlineDevices[0].name
    }
    Process {
        id:openBlueTooth
    }
    onClicked: () => {
        openBlueTooth.exec(["sh", "-c","omarchy-launch-bluetooth"])
        ShellContext.openWindow=""
        ShellContext.trayButton=null
    }
}