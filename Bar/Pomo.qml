import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import QtQuick.Controls
import qs.util
import Quickshell.Io
import Quickshell.Widgets


RowLayout {
    property bool pomoOn: false
    property bool pomoBreak: false
    property bool pomoPause: false
    readonly property var theme: Theme
    property bool rotate: false
    readonly property int baseValue:2100
    property int counter: baseValue
    property string pomoColor: theme.colorFG
    id:pomodoroComponent
    Process {
        id:notifier 
        running:false
    }
    IpcHandler {
        target: "pomodoroComponent"
        function updateRunning(value:string) {
            if(value == "stop") {
                counter=baseValue
                pomoOn=false
                pomoBreak=false
                pomoPause=false

            }
            if(!pomoOn) return 
            if(value == "pause") {
              
                pomoPause = true 
            }
            if(value == "play") {
                if(!pomoOn) return 
                pomoPause = false
            }
            
        }
    }
    Component {
        id:startButton
        BarButton {
            
            onClicked: () => {
                notifier.exec(['notify-send',"Get to work"])
                pomoOn = true
                secondClick.running = true
                pomoColor = theme.colorGreen
               ShellContext.openWindow=""
               ShellContext.toolTipText = ""
            }
            SVGIcon {
                iconName:"apple"
                anchors.centerIn:parent
                size:20
            }
            toolTipText: "Start the pomodoro"
            panel:"BAR_WINDOW"
        
        }
    }
    function stateUpdater():void {
        if(pomoPause) return ; 
        counter = counter - 1
        pomoBreak = false
        pomoColor = theme.colorGreen
        rotate = !rotate
        //IF we need to restart
        if(counter === 0) {
            counter = baseValue
            notifier.exec(["notify-send","Get to work"])
            return 
        }
        //Break has started
        if(counter === 299) {
            notifier.exec(["notify-send","Take a break"])
        }
        //CHECK IF ON BREAK
        if(counter <= 299) {
            pomoBreak = true
            pomoColor = theme.colorFG
            return ; 
        }
        if(counter <= 899) {
            pomoColor = theme.colorRed
            return ; 
        }
        if(counter <=1499) {
            pomoColor = theme.colorYellowBGHover
            return 
        }

        
        


        
    }
    Timer {
            id:secondClick
            onTriggered: {
                stateUpdater()
            }
            running:false
            interval:1000
            repeat:true
        }
    Component {
        id:pomoRunning
        
        
        Rectangle {
         height:48 - (theme.marginButton * 2)
         
         width:90
         color:theme.colorShell
         radius:theme.buttonRadius
         border {
            width:1
            color:Theme.colorBorder
         }
         SVGIcon {
            rotation:rotate?-20:20
            iconName:!pomoBreak?"apple":"coffee"
            iconColor: pomoColor
            size:20
            anchors {
                left: parent.left
                leftMargin:Theme.marginButton
                verticalCenter: parent.verticalCenter
            }
         }
        component PlayerControls: Button {
            id:controlButton
            property string iName
            property var clickAction
            property string toolTipText
            background: Rectangle{
                color:"transparent"
                border {
                    width:0
                    color:controlButton.hovered?theme.colorFG:theme.colorBorder
                }
            }
            implicitWidth:20
            implicitHeight:20
            font.pixelSize:16
            property var clicked
            hoverEnabled:true
       
            palette.buttonText:this.hovered?theme.colorFG:theme.colorFGDim
            SVGIcon {
                iconName:iName
          
                iconColor:controlButton.hovered?theme.colorFG:theme.colorFGDim
                anchors.centerIn:parent
            }
            onClicked: {
                ShellContext.toolTipText = ""
                    clickAction()
                }
            HH{
                    onHoveredChanged: {
            if(this.hovered) {
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = toolTipText
                ShellContext.toolTipAnchor = controlButton
                ShellContext.currentToolTipPanel="BAR_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }
            }
                
        }
            
         RowLayout {
            anchors {
                right: parent.right
                verticalCenter:parent.verticalCenter
                rightMargin:theme.marginButton
            }
            PlayerControls {
                iName: pomoPause?"playback-pause":"playback-play"
                toolTipText:pomoPause?"Start pomodoro":"Pause pomodoro"
             
                clickAction: () => {
                     pomoPause=!pomoPause
                }
            }
            PlayerControls {
                iName: "playback-stop"
                toolTipText:"Stop pomodoro"
                clickAction: () => {
                    counter=baseValue
                    pomoOn=false
                    pomoBreak=false
                    pomoPause=false
                }
             
            }
            
            
         }
        }
    }

    Loader {
        sourceComponent:pomoOn?pomoRunning:startButton
    }


}