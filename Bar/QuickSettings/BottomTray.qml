import qs.util
import QtQuick.Layouts
import QtQuick

RowLayout {

    height: 36
    spacing:0;
    Layout.fillWidth:true
    Layout.leftMargin:Theme.marginButton
    Layout.rightMargin:Theme.marginButton
    Layout.bottomMargin:8
    Layout.minimumHeight:30
    Layout.topMargin:8
  
    RowLayout {
        height: 36
        spacing:4
        QuickActionButton {
            iName:"power_settings_new"
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
            iName:"monitoring"
            execAction: 'ags request launcherstate system --instance my-shell'
        }
    }
}