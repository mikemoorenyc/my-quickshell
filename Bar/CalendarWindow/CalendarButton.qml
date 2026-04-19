import QtQuick.Layouts
import QtQuick // for Text
import QtQuick.Controls
import qs.util
import qs.Bar
BarButton {
    isActive: ShellContext.openWindow == "CALENDAR_WINDOW"
    id: calendarButton
    toolTipText: "Open the calendar"
    SVGIcon {
    anchors {
        centerIn:parent
        
    }
    
    //iconName:"calendar_month"
    size:16
    iconName:"calendar"
    }
    onClicked: () => {
        if(ShellContext.openWindow == "CALENDAR_WINDOW") {
ShellContext.trayButton = null
    ShellContext.openWindow = ""
            return 
        }
        ShellContext.trayButtonW = calendarButton.implicitWidth
        ShellContext.trayButtonX = calendarButton.x
    ShellContext.trayButton = calendarButton
    ShellContext.openWindow = "CALENDAR_WINDOW"
    }
    onXChanged: {
        if(isActive) {
            ShellContext.trayButtonW = calendarButton.implicitWidth
            ShellContext.trayButtonX = calendarButton.x
        }
    }
    onImplicitWidthChanged: {
        if(isActive) {
            ShellContext.trayButtonW = calendarButton.implicitWidth
            ShellContext.trayButtonX = calendarButton.x
        }
    }
 
       
}