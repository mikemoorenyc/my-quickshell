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
    property real ratio : Quickshell.screens[0].height / Quickshell.screens[0].width
    property int menuW: 800
    property real containerH : (menuW-320) * ratio 
 
 
    property int current: 0
    property string dir: "/home/admin/.config/my-quickshell/backgrounds"
    property list<string> backgrounds: []
  
    z:2
  
    onVisibleChanged :{
        backgroundList.currentIndex=0
    }
    FileView {
        id:backgroundFileName

        path:"/home/admin/.config/my-quickshell/configs/backgroundImage.txt"
        watchChanges: true
        onFileChanged: this.reload()
        onLoaded: {
         
           // pinned = this.text().split(",").map(p=>p.trim())

        }
    }
    Process {
        id:getBackgrounds
        command: ["sh", "-c","ls "+dir+" -1"]
        stdout: StdioCollector {
            onStreamFinished:  {
                backgrounds = this.text.split("\n").filter(b => b.length>0)
                
            }
        }
        running:true
    }
    function setWallpaper() {
        const selectedWallpaper = backgrounds[backgroundList.currentIndex]
        if(!selectedWallpaper) return 
        const filePath = dir+"/"+selectedWallpaper
        backgroundFileName.setText(filePath)
        Quickshell.execDetached(["sh", "-c",'pkill -x swaybg && swaybg -i "'+filePath+'" -m fill &'])
        if(MenuLogic.backMenu) {
                Quickshell.execDetached(["sh", "-c","qs -c /home/admin/.config/my-quickshell ipc call launcherEnv setMenu "+MenuLogic.backMenu.slug])
                ShellContext.launcherMenuBackSlug=""
        } else {
            ShellContext.launcherMenuBackSlug=""
            ShellContext.openWindow=""
            ShellContext.trayButton = null
        }

    }
    focus:true 
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Escape) {
            if(MenuLogic.backMenu) {
                Quickshell.execDetached(["sh", "-c","qs -c /home/admin/.config/my-quickshell ipc call launcherEnv setMenu "+MenuLogic.backMenu.slug])
                ShellContext.launcherMenuBackSlug=""
            }
            ShellContext.openWindow=""
            ShellContext.trayButton = null
            event.accepted = true
        }
            if(event.key === Qt.Key_Up) {
                event.accepted = true
                if( backgroundList.currentIndex === 0) {
                   
                    return 
                }
                 backgroundList.currentIndex =  backgroundList.currentIndex - 1
                
            }
            if(event.key == Qt.Key_Down) {
               
                event.accepted = true
             
                if( backgroundList.currentIndex == backgroundList.count-1) {
                   // current = 0
                    return 
                }
                 backgroundList.currentIndex =  backgroundList.currentIndex + 1
                
            } 
            if(event.key == Qt.Key_Return) {
                
                setWallpaper()
            }
        }

    width:menuW
    implicitHeight:menu.implicitHeight
    
    
    
    
    
    
   
   
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
        width:menuW
        Header{
            menuData:menuData
            title:"Set wallpaper"
            width:menuW
        }
        RowLayout {
            spacing:0
            Layout.fillWidth:true
            
            
            ListView {
                id:backgroundList
                width:320
                height: containerH||270
                model: backgrounds
                clip:true 
                ScrollBar.vertical: ScrollBar { }
                delegate: Button {
                    required property var modelData
                    required property int index
                    property bool active : backgroundList.currentIndex === index
            
                    background: Rectangle{
                        color:active?Theme.colorBlueBGHover:"transparent"
                        anchors {
                            fill:parent
                            leftMargin:2
                         
                        }
                    }
                    implicitHeight:48
                    width:320
            
                    
                    StyledText {
                        text:modelData.split(".")[0]
                        elide:Text.ElideRight
                        anchors {
                            fill:parent
                            margins:14
                            verticalCenter:parent.verticalCenter
                        }
                        
                        font.pixelSize:16
                    }
                    
                    MouseArea {
                        anchors.fill:parent
                        cursorShape:Qt.PointingHandCursor
                        hoverEnabled:true 
                        onClicked: setWallpaper()
                        onMouseYChanged: {
                            if(containsMouse) {
                                backgroundList.currentIndex = index
                            }
                        }
                    }
                }
            }
            Rectangle {
                color:"transparent"
                width:menuW - 320
                height:containerH
                Loader {
                    anchors.fill:parent
                    sourceComponent:screenshot
                    active: backgrounds[backgroundList.currentIndex]!==undefined
                }
                Component {
                    id:screenshot
                    Image {
                    fillMode:Image.PreserveAspectCrop
                    anchors {
                        fill:parent
                        rightMargin:2
                        bottomMargin:2
                    }
                    source: dir+"/"+backgrounds[backgroundList.currentIndex]
                    }
                }
                
            }
        }
        
       
       
            
        
    
        
    
    }
    
    
    
 
}