import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts


Scope {
    LazyLoader {
        active:ShellContext.openWindow.length > 0 && ShellContext.openWindow !== "LAUNCHER_MENU"
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
   
       
        }
        onWheel: {
          ShellContext.openWindow = ""
            ShellContext.trayButton = null
        }
    }
}
    }
}