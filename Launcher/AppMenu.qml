import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Io
import "./menuData.js" as MenuData

Item {
    anchors.centerIn:parent
    property string menuSlug
    property string title
    z:2
    property int current: 0

    onVisibleChanged :{
        current=0
    }
    width:620
    implicitHeight:menu.implicitHeight
    onMenuSlugChanged :{
        menuText.reload()
    }
    Process {
        id:buttonExec
    }
    function executeCommand() {
        const command = menuData.items[current].exec
        console.log(command)
        buttonExec.exec(["sh", "-c",command])
        ShellContext.openWindow=""
        ShellContext.launcherMenuSlug=""
    }
    Rectangle {
        anchors.fill:parent
        color: Theme.colorShell
        border {
            width:2
            color:Theme.colorBorder
        }
        radius:Theme.buttonRadius   
    }
    
    ColumnLayout{
        id:menu
        anchors.left:parent.left
        anchors.right:parent.right
        spacing:0
        width:620
        Header{
            title:"Apps"
        }
        Item {
            id:searchContainer 
            implicitHeight:48
            Layout.fillWidth:true
            Layout.bottomMargin:16
            Layout.leftMargin:14
            Layout.rightMargin:14
            Rectangle {
                anchors.fill:parent 
                color:Theme.colorShellHover
                radius:2
                border {
                    width: textField.focus?2:0
                    color:Theme.colorFG
                }
                Rectangle {
                    visible:textField.focus?false:true
                    color:Theme.colorBorder
                    height:1
                    anchors {
                        left:parent.left
                        bottom:parent.bottom
                        right:parent.right
                    }
                }
            }
            
            Button {
                id:searchButton
                implicitWidth:48
                implicitHeight:48
                background: Rectangle{color:"transparent"}
                
                SVGIcon {
                    iconName:"search"
                    anchors.centerIn:parent
                    iconColor:m.hovered?Theme.colorFG:Theme.colorFGDim
                }
                HH{id:m}
            }
            TextField {
                id:textField
                focus:true 
                background: Rectangle {
                    color:"transparent"
                }
                placeholderText: "Enter app name"
                placeholderTextColor:Theme.colorShellHoverLight
                font {
                    family:Theme.fontSans
                    pixelSize:16
                }
                color:Theme.colorFG
                anchors {
                    left:searchButton.right
                    top:parent.top
                    right:clearButton.left
                    bottom:parent.bottom
                }
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        if(MenuLogic.backMenu) {
                            buttonExec.exec(["sh", "-c","qs -c /home/admin/.config/my-quickshell ipc call launcherEnv setMenu "+MenuLogic.backMenu.slug])
                            ShellContext.launcherMenuBackSlug=""
                        }
                        ShellContext.openWindow=""
                        ShellContext.trayButton = null
                        event.accepted = true
                    }
                    if(event.key === Qt.Key_Up) {
                        event.accepted = true
                        if(current === 0) {
                            current = menuItems.length - 1
                            return 
                        }
                        current = current - 1  
                    }
                    if(event.key == Qt.Key_Down) {
                        event.accepted = true
                        if(current == menuItems.length-1) {
                            current = 0
                            return 
                        }
                        current = current + 1
                    } 
                    if(event.key == Qt.Key_Return) {
                        executeCommand()
                    }
                }
            }
            Button {
                implicitWidth:48
                implicitHeight:48
                background:Rectangle{color:"transparent"}
                anchors {
                    right:parent.right
                    top:parent.top
                }
                SVGIcon {
                    anchors.centerIn:parent
                    iconName:"close"
                    iconColor:m2.hovered?Theme.colorFG:Theme.colorFGDim
                }
                id:clearButton
                HH{id:m2}
            }
        }

        
   
    }
    
    
    
 
}