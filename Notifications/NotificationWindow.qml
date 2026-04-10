import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.Notifications
PanelWindow {
    id:root
    property var trackedNotifs: []
    NotificationServer {
    id: notificationServer
    actionsSupported:true
    onNotification: notif => {
            notif.tracked =true
            
         
        }
    }
  
    anchors {
        right:true
        top:true
    }
    implicitWidth:420
    implicitHeight:notificationRow.implicitHeight
    color:"transparent"

    margins {
        right: 20
        top: 20
    }
    ColumnLayout {
        id:notificationRow
        implicitWidth:parent.width
        spacing:10
        Repeater {
            model:notificationServer.trackedNotifications.values
            
            NotificationContainer {
                required property var modelData
                notif: modelData
     
            }
        }
    }

}