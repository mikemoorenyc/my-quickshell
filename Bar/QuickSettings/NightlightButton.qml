import qs.util
import Quickshell
 import Quickshell.Io 
SettingsButton {
    property bool on: false
    readonly property int normalTemp: 6000
    readonly property int nightTemp : 4000
    iconS:"weather-clear-night"
    iconC: on? Theme.colorTextDark:""
    backgroundFill:Network.vpn || !Network.connected
    buttonColor:on? Theme.colorYellowBG:""
    buttonColorHover: {
        if(on) {
            return Theme.colorYellowBGHover
        }
      
        return ""
    }
    borderColor: {
        if(on) {
            return Theme.colorYellowBGHover
        }
      
        return ""
    }
    onVisibleChanged: {
        checkTemp.running=true
    }
    nText : `Nightlight ${on?"on":"off"}`
    Process {
        id:checkTemp
        command: ["sh", "-c","hyprctl hyprsunset temperature"]
        running:false 
        stdout: StdioCollector {
            onStreamFinished: {
            
                const temp = parseInt(this.text.trim())
                on = temp < 5000
            }
        }
    }
    Process {
        id:run
    }
    onClicked: () => {
        run.exec(["sh", "-c","hyprctl hyprsunset temperature "+(on?6000:4000)])
        on = !on
        
       // openBlueTooth.exec(["sh", "-c","omarchy-launch-wifi"])
       // ShellContext.openWindow=""
      //  ShellContext.trayButton=null
    }
}