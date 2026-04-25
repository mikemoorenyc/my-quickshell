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
        property string toolTipText
        id:soundButton
        background:Rectangle {
            color:soundButton.hovered?Theme.colorBG:"transparent"
            border.width:1
            border.color:Theme.colorBorder
            radius:Theme.buttonRadius

        }
       
        hoverEnabled:true
        onClicked: {
            clickProcess.exec(["sh", "-c",click]) 
            ShellContext.toolTipText = ""
            ShellContext.toolTipState = "idle"
            if(click == "omarchy-launch-audio") {
                ShellContext.openWindow=""
                ShellContext.trayButton=null
            }
        }
        
        
      
        
            SVGIcon{
               
                iconName:i
                anchors {
                   centerIn:parent
                }
            }
        HH{onHoveredChanged: {
            if(this.hovered) {
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = toolTipText
                ShellContext.toolTipAnchor = soundButton
                ShellContext.currentToolTipPanel="QUICKSETTINGS_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }}
    }

  
        SoundControl {
            i:Sound.speakerIcon
            click:"pamixer -t"
            toolTipText: Sound.speakerMuted?"Unmute":"Mute"
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
            hoverEnabled:true
            background:Rectangle {
            
                implicitHeight:4
                height:4
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                radius:Theme.buttonRadius
                color:Theme.colorShellHover
                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: slider.pressed?Theme.colorBlueBG:Theme.colorFG
                    radius: Theme.buttonRadius
                }
            }
            handle: Rectangle {
                
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: sliderHandle.hovered?20:  16
                implicitHeight: sliderHandle.hovered?20:16
                radius: 13
                color: slider.pressed?Theme.colorBlueBG:Theme.colorFG
                border{
                    color:slider.pressed?Theme.colorFG:"transparent"
                    width:2
                }   
                
                
                HH {
                    id:sliderHandle
         
                  
                }
            }
        }
        SoundControl {
            i:"audio-mixer"
            click:"omarchy-launch-audio"
            toolTipText: "Audio settings"
        }

    }
    SettingsText {
        visible: Sound.defaultSpeaker?true:false
        topPadding:0
        text:Sound.defaultSpeaker?Sound.defaultSpeaker.description:""
    }
 
}


