import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts

PanelWindow {
    
    focusable:true
    onVisibleChanged: {
        if (visible) {
      
          // contentContainer.forceActiveFocus()
        }
    }
 
    color:Theme.colorShell
    aboveWindows:true
    property var anchorPos

    id:panelContainer
   
    
    Item {
        id:contentContainer
        focus:true
        Keys.onPressed: (event) => {
            console.log("adsf")
            if (event.key === Qt.Key_Escape) {
                ShellContext.openWindow=""
                event.accepted = true
            }
        }
        
        

        anchors.fill:parent
        Rectangle {
        id:fillRectangle
        border {
            width: 2
            color:Theme.colorBorder
            
        }
        anchors.fill:parent
        color:Theme.colorShell

 
    
    }

    
    Rectangle {
        id:buttonMask
        color:Theme.colorShell
        implicitWidth:ShellContext.trayButton.implicitWidth -4
        implicitHeight:2
        anchors {
         
            bottom:parent.bottom
            left:parent.left
            leftMargin: {
                var panelX = Quickshell.screens[0].width - (panelContainer.implicitWidth + panelContainer.margins.right)
                return ShellContext.trayButton.x - panelX + 2
            }
           
        }
    }
    Rectangle {
        id:fullMask
        color:Theme.colorShell
        height:1
        
        anchors {
            left:parent.left
            right:parent.right
            bottom:parent.bottom
            bottomMargin:1
            leftMargin:2
            rightMargin:2
        }
    }
    MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.forceActiveFocus()
                // Consume click, don't close
            }
        }

    }
  

}