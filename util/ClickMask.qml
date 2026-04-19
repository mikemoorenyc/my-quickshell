import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts


PanelWindow {
    color:"transparent"
    visible:ShellContext.openWindow.length
  //visible:false
    anchors {
        left:true
        top:true
        bottom:true
        right:true
    }

    MouseArea {
        anchors.fill:parent
        onClicked: {
            ShellContext.openWindow = ""
            ShellContext.trayButton = null
            console.log("lr")
        }
        onWheel: {
            ShellContext.openWindow = ""
            ShellContext.trayButton = null
        }
    }
}