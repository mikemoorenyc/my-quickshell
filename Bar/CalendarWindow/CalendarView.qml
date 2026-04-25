import qs.util
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
 import Qt5Compat.GraphicalEffects
ColumnLayout {
    Layout.fillWidth:true
    spacing:0
    id:calendarContainer
  
    RowLayout {
        id:calendarHeader
        Layout.fillWidth:true
        Layout.leftMargin:16
        Layout.rightMargin:16
        Layout.topMargin:8
        Layout.bottomMargin:12
        StyledText {
            id:month
            font.pixelSize:18
            text:Qt.formatDateTime(Calendar.date, "MMMM yyyy")
        }
        Rectangle {
            Layout.fillWidth:true
            
        }
        component MonthChanger: Button {
            property string iName: "chevron-down"
            property int delta: 1
            hoverEnabled:true
            implicitWidth: 20
            implicitHeight:20
            background: Rectangle {
                anchors.fill:parent
                color:hovered?Theme.colorBG:"transparent"
                radius:Theme.buttonRadius
                border {
                    color:Theme.colorBorder
                }
            }
            onClicked: () => {
                    Calendar.shiftMonth(delta)
                }
            HH{}

            SVGIcon {
                anchors.centerIn:parent
                iconName:iName
            }
        }
        MonthChanger{
            visible: {
                var n = new Date(); 
               
                return Calendar.month !== n.getMonth() || Calendar.year !== n.getFullYear()
            }
            iName:"chevron-up"
            delta: -1
        }
        MonthChanger{}
    }

    RowLayout {
        id:weekdayHeader
        Layout.fillWidth:true
        spacing:0
        Layout.bottomMargin:8
        Repeater {
            model:["S","M","T","W","T","F","S"]
            Layout.fillWidth:true
            Item{
                required property string modelData
                required property int index
                Layout.fillWidth:true
                width:weekdayHeader.implicitWidth/7
                height:textData.implicitHeight
               
                StyledText {
                id:textData
                text:modelData
                Layout.fillWidth:true
                anchors.horizontalCenter:parent.horizontalCenter
                color: {
     
                    if(modelData == "S") {
                        return Theme.colorFGDim
                    }
                    return Theme.colorFG
                }
               
                }
            }
        }
    }
    Column {
        Layout.fillWidth:true
        Repeater {
            Layout.fillWidth:true
            model:Calendar.layout
            Row {
                id:calRow
                required property var modelData
                Layout.fillWidth:true
                spacing:0
                Repeater {
                    Layout.fillWidth:true
                    model:modelData
                    Rectangle {
                        required property var modelData
                        required property var index
                        width:calendarContainer.width/7
                        height:65
                        color:"transparent"
                        Rectangle {
                            color:Theme.colorBorder
                            anchors {
                                top:parent.top
                                left:parent.left
                                right:parent.right
                            }
                  
                            height:1
                        }
                        Rectangle {
                            color:Theme.colorBorder
                            width:1
                            anchors {
                                left:parent.left
                                top:parent.top
                                bottom:parent.bottom
                            }
                            visible:index !==0
                        }
                        Rectangle {
                            anchors {
                                top:parent.top
                                horizontalCenter:parent.horizontalCenter
                                topMargin:6
                            }
                            width:18
                            height:18
                            radius:30
                            color:modelData.isToday?Theme.colorBlueBG:"transparent"
                            StyledText {
                                color: {
                                    if(modelData.isToday) return "white"
                                    if(modelData.isOtherMonth) return Theme.colorFGDim
                                    return Theme.colorFG
                                }
                            
                                text:modelData.day
                                font.pixelSize:12
                                anchors.centerIn:parent
                            }
                        }
                        
                    }
                }

            }
        }
    }
    /*
    Repeater {
        model:Calendar.layout
        Layout.fillWidth:true
     
         
            RowLayout {
                Layout.fillWidth:true
                id:calRow
                
                Repeater {
                    Layout.fillWidth:true
                    model:modelData
                 
                     
                    Rectangle {
                        implicitWidth:calRow.implicitWidth/7
                        implicitHeight:50
                        color:"red"
                    }
                    
                }

            }
        
    }
    */
}