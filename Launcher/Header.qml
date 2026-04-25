import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io


RowLayout {
    id:header
    spacing:0
    Layout.fillWidth:true
    property string w
    property var menuData
    property var menus
    property string title: MenuLogic.currentMenu?MenuLogic.currentMenu.title:""
    Process {
        id:buttonExec
    }
    
  

   
    ColumnLayout {
        id:text
        spacing:0
        Layout.fillWidth:true
        Layout.margins:14
        Layout.bottomMargin:12

        Layout.alignment:Qt.AlignTop|Qt.AlignLeft
        Button {
            id:backButton
            visible:MenuLogic.backMenu!== undefined
            Layout.bottomMargin:4
            background:Rectangle{color:"transparent"}
            hoverEnabled:true
            implicitWidth:buttonInsides.implicitWidth
            implicitHeight:buttonInsides.implicitHeight
            RowLayout {
                id: buttonInsides
                spacing:4
                SVGIcon {
                    iconName:"chevron-left"
                    iconColor:backButton.hovered?Theme.colorFG:Theme.colorFGDim
                }
                StyledText {
                    color:backButton.hovered?Theme.colorFG:Theme.colorFGDim
                    text:MenuLogic.backMenu?MenuLogic.backMenu.title:""
                }
            }
            onClicked: {
                Quickshell.execDetached(["sh", "-c","qs -c /home/admin/.config/my-quickshell ipc call launcherEnv setMenu "+MenuLogic.backMenu.slug])
                ShellContext.launcherMenuBackSlug=""
            }
            HH{}

        }
        
        StyledText {
            text:title
            font.pixelSize:20
            Layout.fillWidth:true
            elide:Text.ElideRight
        }
    }
    Button {
        id:closeButton
        implicitWidth:48
        implicitHeight:48
        Layout.alignment:Qt.AlignTop|Qt.AlignLeft
        background:Rectangle{color:"transparent"}
        SVGIcon {
            iconName:"close"
            iconColor:closeButton.hovered?Theme.colorFG:Theme.colorFGDim
            anchors.centerIn:parent
        }
        onClicked: {
            console.log("x click")
            ShellContext.launcherMenuSlug=""
            ShellContext.launcherMenuBackSlug=""
        }
        HH{}
        
    }
}