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
    property string iconC
    signal clicked 
  

    readonly property string inBtnColor: buttonColor||Theme.colorShellHover
    readonly property string inBtnColorHover: buttonColorHover||Theme.colorShellHoverLight
    readonly property string inBorderColor: borderColor || Theme.colorShellHoverLight
    readonly property string inIconColor: iconC || Theme.colorFG
    

    Button {
        
        Layout.fillWidth:true
        implicitHeight:52
        id:bigButton
       /* CDIcon{
            size:24
            iconName:iconS
            iconColor:iconC
            anchors.centerIn:parent            
        }
        */
        SVGIcon {
            anchors.centerIn:parent 
            size:24
            iconName:iconS
            iconColor:iconC
        }

        background: Rectangle {
            radius:Theme.buttonRadius
            color:bigButton.hovered?inBtnColorHover:inBtnColor 
            border {
                width:1
                color:inBorderColor
            }
        }
        onClicked: {
            settingsButton.clicked()
        }
        hoverEnabled:true
        HH{}
        
        
    }
    SettingsText {
        text:nText

    }
}
