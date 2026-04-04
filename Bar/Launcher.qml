import QtQuick // for Text
import QtQuick.Controls
import "../util/"
import Quickshell.Widgets


Button {
    id:launcherButton
    implicitHeight:48
    implicitWidth:32
    hoverEnabled:true
    background:Rectangle {
        color:"transparent"
    }
    property string btnColor: this.hovered?Theme.colorFG:Theme.colorFGDim
    
    font.family: Theme.fontIcon
    font.pixelSize:20
    palette.buttonText: btnColor
    Rectangle {
        color:launcherButton.hovered?Theme.colorShell:"transparent"
        border {
            color: btnColor
            width: 1
        }
        radius:Theme.buttonRadius
        anchors {
            fill:parent
            topMargin:Theme.marginButton
                bottomMargin:Theme.marginButton
        }
        
    }
    CDIcon {
        anchors.centerIn:parent
        iconName:"apps"
    }
    MouseArea {
        anchors.fill:parent
        hoverEnabled:true
        cursorShape:Qt.PointingHandCursor
    }
   
}