import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets


Button {
    id:launcherButton
    implicitHeight:48
    implicitWidth:32
    hoverEnabled:true
    background:Rectangle {
        color:"transparent"
    }
    onClicked: {
        ShellContext.openWindow = "LAUNCHER_MENU"
        ShellContext.launcherMenuSlug = "settings"
    }
    property string btnColor: Theme.colorFG
    
    font.family: Theme.fontIcon
    font.pixelSize:20
    palette.buttonText: btnColor
    Rectangle {
        color:launcherButton.hovered?Theme.colorGreyBGHover:Theme.colorGreyBG
      
        radius:Theme.buttonRadius
        anchors {
            fill:parent
            topMargin:Theme.marginButton
                bottomMargin:Theme.marginButton
        }
       
        
    }
    SVGIcon {
        anchors.centerIn:parent
        iconName:"apps"
  
    }
  
    HH{
        onHoveredChanged: {
            if(this.hovered) {
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = "Main menu"
                ShellContext.toolTipAnchor = launcherButton
                ShellContext.currentToolTipPanel="BAR_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }
    }
    
 
}