import QtQuick // for Text
import QtQuick.Controls
import "../util/"
import Quickshell.Widgets


Rectangle {
    id:barButton
    implicitHeight:48
    implicitWidth:32
    property string iconString
    readonly property var theme: Theme
    property bool isActive:false
    property var click
    property string backgroundColor: "transparent"
    property string backgroundColorHover: theme.colorShell
   
    property string borderColor: theme.colorBorder
    property string borderColorHover:borderColor
    property  bool hoverColor: (mouseArea.hovered || isActive)
    signal clicked 
 

    color:"transparent"
        
        Rectangle {
            color:hoverColor?backgroundColorHover:backgroundColor
            anchors {
                fill:parent
                topMargin:isActive?0:theme.marginButton
                bottomMargin:theme.marginButton
            }
            border.color:hoverColor?borderColorHover:borderColor
            border.width:isActive?2:1
            radius:theme.buttonRadius
          
        }
        Rectangle {
            id: activeShim 
            color:theme.colorShell
            implicitHeight:theme.marginButton
            anchors {
                left: parent.left
                right:parent.right
                leftMargin:2
                rightMargin:2
            }
            visible:isActive

        }
      
        Button {
         onClicked: {
                barButton.clicked()
            }
        font.family: theme.fontIcon
        font.pixelSize:22
        hoverEnabled:true
        anchors {
            fill:parent
        }
        palette {
            buttonText:theme.colorFG
        }
       
   


    
        implicitHeight:48
        implicitWidth:36
        text:iconString
        background:Rectangle {
            color:"transparent"
        }
        HH{id:mouseArea}
        
    }
}