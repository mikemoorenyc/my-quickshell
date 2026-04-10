import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Io


BarButton {
    property bool isRecording: false 
    id:screenRecording
    backgroundColor:Theme.colorRedDim
    backgroundColorHover:Theme.colorRedBG
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
    
    CDIcon {
        iconName:"screen_record"
        anchors.centerIn:parent
        iconColor:"white"
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
