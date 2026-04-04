import qs.util
import QtQuick.Layouts
import QtQuick

RowLayout {
    anchors {
        left:parent.left
        right:parent.right
        leftMargin:Theme.marginButton/2
        rightMargin:Theme.marginButton/2
    }
    height: 36
    spacing:0;
    Layout.minimumHeight:30
  
    RowLayout {
        height: 36
        spacing:4
        QuickActionButton {
            iName:"power"
            execAction: 'ags request launcherstate system --instance my-shell'
        }
    }
    Rectangle {
        Layout.fillWidth:true
    }
    RowLayout {
        height: 36
        spacing:4
        QuickActionButton {
            iName:"settings"
            execAction: 'ags request launcherstate system --instance my-shell'
        }
        QuickActionButton {
            iName:"pulse"
            execAction: 'ags request launcherstate system --instance my-shell'
        }
    }
}