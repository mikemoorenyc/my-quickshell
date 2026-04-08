import QtQuick.Layouts
import QtQuick // for Text
import QtQuick.Controls
import qs.util
import qs.Bar
BarButton {
    isActive: ShellContext.openWindow == "CALENDAR_WINDOW"
    id: calendarButton
    CDIcon {
    anchors {
        centerIn:parent
        
    }
    size:16
    iconName:"calendar_month"
    }
    click: () => {
    ShellContext.trayButton = calendarButton
    ShellContext.openWindow = "CALENDAR_WINDOW"
    }
 
       
}