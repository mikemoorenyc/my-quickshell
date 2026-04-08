import qs.util
import QtQuick.Layouts
import QtQuick
 import Quickshell.Io 
PanelContainer {
    
    id:quickSettingsContainer
    anchors {
        right: true
        bottom: true
    }
    Process {
        id:actioner
    }
    margins {
        right: 12
        bottom: 0
    }
    implicitHeight:quickSettingsInner.implicitHeight  + 4
    implicitWidth:360 + 4
    visible: ShellContext.openWindow == "QUICKSETTINGS_WINDOW"
   
    ColumnLayout {
        id: quickSettingsInner
        width:360
        anchors.centerIn:parent
        spacing: 0;
         GridLayout {
            Layout.fillWidth:true
            Layout.leftMargin:16
            Layout.rightMargin:16
            Layout.topMargin:20
            columns:3
            uniformCellWidths:true
            rowSpacing:12
            columnSpacing:12
            BluetoothButton{}
            NetworkButton{}
            SettingsButton{
                iconS: "colorize"
                nText:"Color picker"
                Timer {
                    id:waitToClose
                    onTriggered: {
                        ShellContext.openWindow=""
                        ShellContext.trayButton=null
                        interval:500
                        running:false
                    }
                }
                onClicked: {
                    actioner.exec(["sh", "-c","hyprpicker -a"])
                    waitToClose.running = true
                   
                }
            }
            SettingsButton{
                iconS: "screenshot_frame_2"
                nText: "Screen capture"
                Timer {
                    id:waitToCap
                    onTriggered: {
                        actioner.exec(["sh", "-c","omarchy-cmd-screenshot"])
                        interval:0
                        running:false
                    }
                }
                onClicked: {
                    
                    ShellContext.openWindow=""
                    ShellContext.trayButton=null
                    waitToCap.running = true
                }
            }
            SettingsButton{
                iconS: "screen_record"
                nText: "Screen record"
                onClicked: {
                    ShellContext.openWindow=""
                    ShellContext.trayButton=null
                    actioner.exec(["/home/admin/.config/my-quickshell/scripts/screen-detach.sh"])
                }
            }
        }
        VolumeSlider{}
        Rectangle {
            height:20
        }
        Rectangle {
            height:1
            width:parent.width
            color:Theme.colorBorder
        }
        BottomTray{}

    }

}