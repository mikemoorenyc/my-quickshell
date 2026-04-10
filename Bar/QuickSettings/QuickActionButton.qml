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
    implicitWidth:24
    implicitHeight:24
    background: Rectangle {
        color:"transparent"
    }
    Process{
        id:executor
    }
    CDIcon {
        iconName:iName
        anchors.centerIn:parent
        iconColor: quickActionButton.hovered ?Theme.colorFG :Theme.colorFGDim
        
    }
    onClicked: () => {
            executor.exec(["sh", "-c",execAction]) 
        }
    HH{}
  
    
}