import qs.util
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
 import Quickshell.Io 

Button {
    id:quickActionButton
    hoverEnabled:true
    property string execAction
    property string iName
    property string toolTipText
    implicitWidth:24
    implicitHeight:24
    background: Rectangle {
        color:"transparent"
    }
    Process{
        id:executor
    }
    SVGIcon {
        iconName:iName
        anchors.centerIn:parent
        iconColor: quickActionButton.hovered ?Theme.colorFG :Theme.colorFGDim
        
    }
    onClicked: () => {
            executor.exec(["sh", "-c",execAction]) 
        }
    HH{
        onHoveredChanged: {
            if(this.hovered) {
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = toolTipText
                ShellContext.toolTipAnchor = quickActionButton
                ShellContext.currentToolTipPanel="QUICKSETTINGS_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }
    }
  
    
}