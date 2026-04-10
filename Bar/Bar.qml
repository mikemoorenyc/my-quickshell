import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import qs.Bar.Weather
import qs.Bar.QuickSettings
import qs.Bar.CalendarWindow
import "../util/"
import qs.Bar.Tray
import qs.Bar.Apps
//#6a7a00
PanelWindow {
    readonly property var theme: Theme
  anchors {
    bottom:true
    left: true
    right: true
  }
  id:barContainer
  implicitHeight:48
  color:theme.colorBG

  

  Rectangle {
    color:theme.colorBorder
    implicitHeight:1
    anchors {
      top:parent.top
      left:parent.left
      right:parent.right
    }
  }

  RowLayout {
    spacing:theme.marginButton;
    anchors {
        fill:parent
    }
    
    Item {
      RowLayout {
        spacing:theme.marginButton
        Launcher {}
        UpdateAvailable {}
      }
      MarginWrapperManager {
        leftMargin:12
      }
    }
    
    Item {
      height:48
      
        Layout.fillWidth: true
        MouseArea {
          anchors.fill:parent
          onClicked: {
            ShellContext.openWindow=""
          }
        }

    }
    AppBar{}
    Item {
      height:48
      
        Layout.fillWidth: true
        MouseArea {
          anchors.fill:parent
          onClicked: {
            ShellContext.openWindow=""
          }
        }

    }
    ScreenRecording{}
    Pomo{}
    MicActive{}
    TrayButton{}
    QuickSettingsButton{}
    WeatherButton{}
    Clock{
    }
    CalendarButton{Layout.rightMargin:12}
    
    
    
  }
 /*MouseArea {
    visible:ShellContext.openWindow.length
    anchors.fill:parent
    onClicked: {
      ShellContext.openWindow=""
      ShellContext.trayButton = null
    }
  }*/
  

}