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
    property var menuItems:MenuLogic.currentMenu?MenuLogic.currentMenu.items:[]
    property var menuData : MenuLogic.currentMenu
    property var menus 
    property int current: 0
    z:2
    property string menuRaw
    onVisibleChanged :{
        current=0
    }
   
        
             focus:true 
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

    width:320
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
        width:320
        
    
        
        Header{
            menuData:menuData

     
        }
        
       
        Repeater {
            model:menuItems
            Layout.fillWidth:true
            Button {
                required property var modelData
                required property int index
                property bool active : current === index
            
                Layout.fillWidth:true
                background: Rectangle{
                    color:active?Theme.colorBlueBGHover:"transparent"
                }
                implicitHeight:48
                Layout.leftMargin:2
                Layout.rightMargin:2
                Layout.bottomMargin:2
                
                
                RowLayout {
                    anchors.fill:parent
                    SVGIcon{
                        iconName:modelData.icon||"chevron-right"
                     
                        Layout.leftMargin:14
                        Layout.alignment:Qt.AlignVCenter
                    }
                    StyledText {
                        text:modelData.title
                        elide:Text.ElideRight
                        Layout.alignment:Qt.AlignVCenter|Qt.AlignLeft
                        Layout.margins:14
                        Layout.fillWidth:true
                        font.pixelSize:16

                    }
                }
                MouseArea {
                 anchors.fill:parent
                 cursorShape:Qt.PointingHandCursor
                 hoverEnabled:true 
                 onClicked: {
                    
                    executeCommand()
                 }
                 onContainsMouseChanged: {
                    if(containsMouse) {
                       // current = index
                    } else {
                      //  current = -1 
                    }
                 }   
                 onMouseYChanged: {
                    if(containsMouse) {
                        current = index
                    }
                 }
                }
            }
        }
            
        
    
        
    
    }
    
    
    
 
}