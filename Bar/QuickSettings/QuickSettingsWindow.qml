import qs.util
import QtQuick.Layouts
import QtQuick

PanelContainer {
    id:quickSettingsContainer
    anchors {
        right: true
        bottom: true
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