import qs.util
import Quickshell
 import Quickshell.Io 
 import Quickshell.Services.UPower
SettingsButton {
    property bool on: PowerProfiles.profile===0

    iconS:"energy-saver"
    buttonColor:on?Theme.colorGreenBG:""
    buttonColorHover:on?Theme.colorGreenBGHover:""
    borderColor:on?Theme.colorGreenBGHover:""

    nText : `Powersaver ${on ? "on":"off"}`
    
    onClicked: () => {
        if(on) {
            PowerProfiles.profile = PowerProfile.Balanced
        } else {
            PowerProfiles.profile = PowerProfile.PowerSaver
        }
        
        
       // openBlueTooth.exec(["sh", "-c","omarchy-launch-wifi"])
       // ShellContext.openWindow=""
      //  ShellContext.trayButton=null
    }
}