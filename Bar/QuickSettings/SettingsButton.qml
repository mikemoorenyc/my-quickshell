import qs.util
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

ColumnLayout {
    id:settingsButton
    width:parent.implicitWidth/3
    property string iconS:"apps"
    property string nText: "Filler Text"
    property var click
    property string buttonColor
    property string buttonColorHover
    property string borderColor
    property bool backgroundFill:false
    signal clicked 
  

    readonly property string inBtnColor: buttonColor||Theme.colorBG
    readonly property string inBtnColorHover: buttonColorHover||Theme.colorBorderDark
    readonly property string inBorderColor: borderColor || Theme.colorBorder
    

    Button {
        
        Layout.fillWidth:true
        implicitHeight:52
        id:bigButton
        CDIcon{
            size:24
            iconName:iconS
            iconColor:backgroundFill?"white":Theme.colorFG
            anchors.centerIn:parent            
        }
        

        background: Rectangle {
            radius:Theme.buttonRadius
            color:bigButton.hovered?inBtnColorHover:inBtnColor 
            border {
                width:1
                color:inBorderColor
            }
        }
 
        hoverEnabled:true
        onClicked: {
           settingsButton.clicked()
        }
        
    }
    SettingsText {
        text:nText

    }
}
