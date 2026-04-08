import qs.util
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import qs.Bar
 import Quickshell.Io 

ColumnLayout {
      Layout.fillWidth:true
    Layout.leftMargin:16
    Layout.rightMargin:16
    Layout.topMargin:20

     Process {
            id:clickProcess
        }

    RowLayout {
    Layout.fillWidth:true
    component SoundControl: Button{
        implicitHeight:28
        implicitWidth:28
        property string i
        property var click
        id:soundButton
        background:Rectangle {
            color:"transparent"
            border.width:1
            border.color:soundButton.hovered?Theme.colorFG:Theme.colorBorder
            radius:Theme.buttonRadius

        }
       
        hoverEnabled:true
        onClicked: {
            clickProcess.exec(["sh", "-c",click]) 
            if(click == "omarchy-launch-audio") {
                ShellContext.openWindow=""
                ShellContext.trayButton=null
            }
        }
        
        
      
        
            CDIcon{
                size:22
                iconName:i
                anchors {
                    horizontalCenter:parent.horizontalCenter
                    top:parent.top
                }
            }
        
    }

  
        SoundControl {
            i:Sound.speakerIcon
            click:"pamixer -t"
        }
        Slider {
            Layout.fillWidth:true
            Layout.leftMargin:8
            Layout.rightMargin:8
            from:0
            to:1
            stepSize:.05
            value:Sound.defaultAudio?Sound.defaultAudio.volume:0
            onValueChanged: {
                if(Sound.defaultAudio) {
                    Sound.defaultAudio.volume = this.value
                }
               
            }
            id: slider
            background:Rectangle {
            
                implicitHeight:6
                height:6
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                radius:Theme.buttonRadius
                color:Theme.colorBG
                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: Theme.colorYellowBG
                    radius: Theme.buttonRadius
                }
            }
            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 20
                implicitHeight: 20
                radius: 13
                color: Theme.colorFG
                border.width:0
            }
        }
        SoundControl {
            i:"equalizer"
            click:"omarchy-launch-audio"
        }

    }
    SettingsText {
        visible: Sound.defaultSpeaker?true:false
        topPadding:4
        text:Sound.defaultSpeaker?Sound.defaultSpeaker.description:""
    }
 
}


