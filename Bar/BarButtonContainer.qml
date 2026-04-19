import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets
import QtQuick.Layouts


Button {
    readonly property var theme: Theme 
    implicitWidth:container.implicitWidth + (theme.marginButton * 2)
    implicitHeight:48
    hoverEnabled:true
    property var click
    property bool isActive:false
    property string toolTipText
    id:barContainerButton
    background: Rectangle {
        color:"transparent"
    }
    onClicked: ()=> {
        ShellContext.toolTipText=""
        ShellContext.toolTipState="idle"
        click(); 
    }
    HH{
        onHoveredChanged: {
            
            if(toolTipText.length < 1) {
                ShellContext.toolTipState="idle"
                return 
            }
            if(this.hovered) {
                if(ShellContext.openWindow.length > 1) return 
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = toolTipText
                ShellContext.toolTipAnchor = barContainerButton
                ShellContext.currentToolTipPanel="BAR_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }
    }
   
    
    Rectangle {
        anchors{
            fill:parent
            topMargin:isActive?0:theme.marginButton
            bottomMargin:theme.marginButton
        }
        color:(barContainerButton.hovered || isActive)?theme.colorShell:"transparent"
        border {
            width:isActive?2:1
            color:theme.colorBorder
            
        }
        radius:theme.buttonRadius
    }
    Rectangle {
        id:overflowSpacer
        color:theme.colorShell
        implicitHeight:2
        visible:isActive
        anchors {
            top:parent.top
            left:parent.left
            right:parent.right
            leftMargin:2
            rightMargin:2
        }
    }

 
        
    
}