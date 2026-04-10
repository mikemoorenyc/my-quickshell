import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
import qs.util

Rectangle {
    width:48
    height:48
    property string appId
    color:"transparent"
    property bool aToplevel : ToplevelManager.activeToplevel && ToplevelManager.activeToplevel.appId == appId
    property var windows : {
        return ToplevelManager.toplevels.values.filter(m => m.appId === appId)
    }
    
    Button {
        id:appButton
        anchors.fill:parent
        background:Rectangle{color:"transparent"}
        hoverEnabled:true
        onHoveredChanged: {
            thumbnailShower.running = appButton.hovered
        }
        HH{}
        onClicked: {
            windows[0].activate()
            console.log(appButton.mapToItem(null,0,0))
            ShellContext.openWindow=""
        }
        Timer {
            id:thumbnailShower
            interval: 2000
            running:false
            onTriggered: {
                console.log("trigger")
            }
        }
        
        
        Rectangle {
            
            radius:2

            color:"transparent"
            anchors {
                fill:parent
                margins:6
                rightMargin: 0
            }
            border {
                width:1
                color:aToplevel?Theme.colorBlueBG:Theme.colorBorder
            }
            visible:windows.length > 1
        }
        Rectangle {
            
            radius:2

            color:Theme.colorBG
            anchors {
                fill:parent
                margins:6
                rightMargin: 3
            }
            visible:windows.length > 1
            
        }
        Rectangle {
            
            radius:2

            color:appButton.hovered?Theme.colorShell:Theme.colorBG
            anchors {
                fill:parent
                margins:6
            }
            border {
                width:1
                color:aToplevel ?Theme.colorBlueBG:Theme.colorBorder
            }
        }
        
        Image {
            anchors.centerIn:parent
            width:24
            height:24
            sourceSize {
                width:24
                height:24
            }
            source:"image://icon/"+appId
        }

        

    }
    
}