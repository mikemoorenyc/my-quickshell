import qs.util
import QtQuick.Layouts
import QtQuick
import Quickshell

Scope {
    LazyLoader {
        active: ShellContext.openWindow == "CALENDAR_WINDOW"
        PanelContainer {
    id:calendarWindow
    visible: ShellContext.openWindow == "CALENDAR_WINDOW"
    Component.onCompleted: {
        ShellContext.panelRefs.set("CALENDAR_WINDOW",calendarWindow)
    }
    anchors {
        right: true
        bottom: true
    }
    margins {
        right: 12
        bottom: 0
    }
    implicitWidth: calendarInner.width + 4
    implicitHeight:calendarInner.implicitHeight + 4
    property bool detailOpen: false
    onVisibleChanged: {
        detailOpen = false
        Calendar.reset()
    }
    
    ColumnLayout {
       id:calendarInner
        anchors.centerIn:parent
       width:360
    
    
       CalendarView{visible:!detailOpen}
    }
   
}

    }
}

