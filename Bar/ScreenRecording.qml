import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Io


BarButton {
    property bool isRecording: false 
    id:screenRecording
    backgroundColor:Theme.colorRedBG
    backgroundColorHover:Theme.colorRedBGHover
    borderColor:Theme.colorRedBG
    
    visible: isRecording
    
    Process {
        id:checker
        running: false 
        command: [ "/home/admin/.config/my-quickshell/scripts/screen-check.sh"]
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(`line read: ${this.text}`)
                isRecording = this.text.trim() == "true"
            }
        }
    }
    Process {
        id:shutOff
    }
    
    SVGIcon {
        iconName:"video"
        anchors.centerIn:parent
      
    }
    
    IpcHandler {
        target: "screenRecording"
        function checkActive(value:string) {
      
            checker.running=true
        }
    }


    onClicked: () => {
       shutOff.exec(["/home/admin/.config/my-quickshell/scripts/screen-detach.sh"]) 
    }
}
