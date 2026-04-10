import QtQuick.Layouts
import QtQuick 
import qs.util
import QtQuick.Controls

import Quickshell.Widgets
Item {
    id:notificationOuter
    
    property var notif
    implicitWidth:420
    height:contentContainer.implicitHeight
    property string textHeadline : notif.summary
    property string textBody:notif.body
    property int urgency:notif.urgency??1
    property string imagePath:{
        if(notif.image) return notif.image
        if(notif.appIcon) return "image://icon/"+notif.appIcon
        return ""
    }
    property var actions: []
    property string warningColor : {
        if(urgency ===0) {
            return Theme.colorGreenBG
        }
        if(urgency == 2) {
            return Theme.colorRedBG
        }
        return Theme.colorBlueBG     
    }
    Timer {
        id:expireTimer
        running: notif.urgency!==2 && notif.expireTimeout !== 0
        interval: {
            if(notif.expireTimeout===-1) return 5000
            return notif.expireTimeout

        }
        onTriggered :{
            notif.expire() 
        }
    }
    Rectangle {
        anchors.fill:parent
        color:Theme.colorFG
        border {
            width:1
            color:warningColor
        }
    }
    
    RowLayout {
        
        id:contentContainer
        spacing: 8
        anchors {
            left:parent.left
            right:parent.right
            
        }
       
        Rectangle {
            color:warningColor
            width:3
            Layout.fillHeight:true
            Layout.rightMargin:4
        }
        Rectangle {
            width:36
            height: 36
            radius: 36
            //visible:false
            color:Theme.colorRedBG
            visible: urgency==2 && !imagePath
            CDIcon {
                iconName:"exclamation"
                size: 30
                anchors {
                    top:parent.top
                    horizontalCenter:parent.horizontalCenter
                }
                
            }
            Layout.topMargin:12
            Layout.bottomMargin:12
            Layout.alignment:Qt.AlignTop|Qt.AlignLeft
        }
      
        IconImage {
            implicitSize:36
            source:imagePath
            visible:imagePath.length > 0
            Layout.topMargin:12
            Layout.alignment:Qt.AlignTop|Qt.AlignLeft
        }
       
        ColumnLayout {
            id:textContent
            Layout.fillWidth:true
            Layout.alignment:Qt.AlignTop|Qt.AlignLeft
            Layout.topMargin:10
            Layout.bottomMargin:12
            spacing: 4
            StyledText {
                text:textHeadline
                color:Theme.colorTextDark
                font.pixelSize:16
                font.weight:600
                font.letterSpacing:0
                wrapMode:Text.WordWrap
                Layout.fillWidth:true
            }
            StyledText {
                id:bodyT
                text: textBody
                color:Theme.colorTextDark
                font.pixelSize:14
                wrapMode:Text.WordWrap
                textFormat:Text.RichText
                font.letterSpacing:0
                Layout.fillWidth:true
                visible:textBody.length
          
            }
        
        }
        ColumnLayout {
            id:actionContainer
            Layout.alignment:Qt.AlignTop|Qt.AlignLeft
            visible: notif.actions.length>0
            Layout.topMargin:16
            Repeater {
                model:notif.actions 
                Button {
                    required property var modelData
                    Layout.minimumWidth:actionContainer.implicitWidth
                    Layout.preferredWidth:buttonText.implicitWidth
                    hoverEnabled:true
                    id:actionButton
                    Layout.minimumHeight:buttonText.implicitHeight + 8
                  
                    StyledText {
                        id:buttonText
                        text:{return modelData.text.toUpperCase()}
                        color:actionButton.hovered?Theme.colorFG:Theme.colorBlueBG
                        anchors.centerIn:parent
                        font.pixelSize:14
                        leftPadding:10
                        rightPadding:10
                    
                    }
                    background:Rectangle {
                        color:actionButton.hovered?Theme.colorBlueBGHover:"transparent"
                        border {
                        width: 1
                        color:actionButton.hovered?Theme.colorBlueBGHover:Theme.colorBlueBG
                        }
                    }
                    
                    onClicked: {
                        modelData.invoke()
                    }
                    HH{}
                    
                }
            }
        }
        Button {
            id:closeButton
            Layout.preferredWidth:48
            Layout.preferredHeight:48
            Layout.alignment:Qt.AlignTop|Qt.AlignLeft
            background:Rectangle{color:"transparent"}
            CDIcon {
                iconName: "close"
                iconColor:mArea.containsMouse?Theme.colorTextDark:Theme.colorShell
                anchors.centerIn:parent
            }
            MouseArea {
                id:mArea
                hoverEnabled:true
                cursorShape:Qt.PointingHandCursor
                anchors.fill:parent
                onClicked: {
                    notif.dismiss()
                }
            }
            
        }
    }
 

   
}