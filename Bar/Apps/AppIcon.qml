import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
import qs.util
import Quickshell

Rectangle {
    id:appContainer
    property int size: 48
    width:size
    height:size
    property var pos :appContainer.mapToItem(null, 0, 0)
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
            ShellContext.appIconHovering = this.hovered
            if(hovered && ShellContext.openWindow == "PREVIEW_WINDOW") {
                ShellContext.appIcon = appContainer
                ShellContext.previewAppId= appId
            }
            thumbnailShower.running = true
            
        }
        HH{}
        onClicked: {
            windows[0].activate()
            //ShellContext.appIcon = appContainer
            ShellContext.openWindow=""
            //ShellContext.recalculate()
        }
        Timer {
            id:thumbnailShower
            interval: 1000
            running:false
            onTriggered: {
                if(ShellContext.previewHovering) {
                    return 
                }
                if(appButton.hovered) {
                    ShellContext.appIcon = appContainer
                    ShellContext.previewAppId= appId
                    ShellContext.openWindow = "PREVIEW_WINDOW"
                } else {
                    if(ShellContext.previewAppId == appId) {
                        ShellContext.openWindow = ""
                    }
                    
                }
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
            source: {
                return Quickshell.iconPath(appId,true)||Quickshell.iconPath("application-x-executable")
            }
        }
       

        

    }
    
}