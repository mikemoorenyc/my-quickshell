import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Io
import "./menuData.js" as MenuData
import Qt5Compat.GraphicalEffects
import "sortLogic.js" as Fuzzy

Item {
    id:root
    anchors.centerIn:parent
    property string menuSlug
    property string title
    z:2
    property int current: 0

    onVisibleChanged :{
        current=0
        textField.text =""
        appList.currentIndex=0 
    }
    width:620
    implicitHeight:menu.implicitHeight
    onMenuSlugChanged :{
        menuText.reload()
    }
    property int activeIndex: 0
    property list<string> pinned:[]
    property int pn : pinned.length
    property string searchT : textField.text
    property var filterApps: {
        if(searchT.length>1) {
       
            return Fuzzy.go(textField.text,[...DesktopEntries.applications.values],{key:"name"}).map(a=>a.obj).sort((a,b)=>a.name.localeCompare(b.name))
        }
        const pinnedApps = [...DesktopEntries.applications.values].filter(a=>pinned.includes(a.id)).sort((a,b)=>a.name.localeCompare(b.name))
        const unPinnedApps = [...DesktopEntries.applications.values].filter(a=>!pinned.includes(a.id)).sort((a,b)=>a.name.localeCompare(b.name))
        return [...pinnedApps,...unPinnedApps]
    }   
    
    
    FileView {
        id:pinCheck
        path:"/home/admin/.config/my-quickshell/configs/pinnedApps.txt"
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
        onLoaded: {
            console.log("relad")
            pinned = this.text().split(",").map(p=>p.trim())

        }
    }
    function updatePinned(id,addPin=true) {
        if(addPin) {
            pinned = [...pinned, ...[id]]
        } else {
            pinned = pinned.filter(a => a!== id)
        }
        appList.currentIndex=0
        pinCheck.setText(pinned.join(","))
    }
    function openApp(id) {
        const app =DesktopEntries.byId(id)
        if(!app) return
        if(app.runInTerminal) {
            Quickshell.execDetached(["sh", "-c", "setsid uwsm-app -- xdg-terminal-exec "+app.id])
        }
        ShellContext.openWindow=""
    
        ShellContext.trayButton = null
        ShellContext.launcherMenuBackSlug=""
        app.execute()
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
                color:Theme.colorBG
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
                onTextChanged: {
                    appList.currentIndex = 0
                }
                Keys.onPressed: (event) => {
                 //   appList.currentIndex = 0
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
                        if(appList.currentIndex === 0) {
                          //  appList.currentIndex = appList.count - 1
                            return 
                        }
                        appList.currentIndex = appList.currentIndex - 1  
                    }
                    if(event.key == Qt.Key_Down) {
                        event.accepted = true
                        if(appList.currentIndex == appList.count-1) {
                          //  appList.currentIndex = 0
                            return 
                        }
                        appList.currentIndex = appList.currentIndex + 1
                    } 
                    if(event.key == Qt.Key_Return) {
                        console.log(appList.currentItem.appId)
                        openApp(appList.currentItem.appId)
                        //executeCommand()
                    }
                }
            }
            Button {
                implicitWidth:48
                implicitHeight:48
                visible: textField.text.length > 1
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
                onClicked: {
                    textField.text = ""
                    textField.focus=true
                }
                HH{id:m2}
            }
        }
      
        ListView {
            id:appList
            Layout.fillWidth:true
            Layout.margins:14
            Layout.topMargin:0;
           implicitHeight:600
           ScrollBar.vertical: ScrollBar { }
           keyNavigationEnabled:true
           Timer {
            id:setter
            onTriggered: {
                appList.currentIndex=0
            }
            running:false
            interval:100
           }
           Component.onCompleted: {
            setter.running = true 
           }
           
           
          
            
            
            
            model:ScriptModel {
                values: {
                    if(searchT.length>1) {
       
            return Fuzzy.go(textField.text,[...DesktopEntries.applications.values],{key:"name"}).map(a=>a.obj).sort((a,b)=>a.name.localeCompare(b.name)).filter(a => a.comment !== "Play this game on Steam")
        }
        
        const pinnedApps = DesktopEntries.applications.values.filter(a=>pinned.includes(a.id)).sort((a,b)=>a.name.localeCompare(b.name))
        const unPinnedApps = DesktopEntries.applications.values.filter(a=>!pinned.includes(a.id)).sort((a,b)=>a.name.localeCompare(b.name))
        return pinnedApps.concat(unPinnedApps).filter(a => a.comment !== "Play this game on Steam")
                }
            }
            clip:true
            delegate : Rectangle{
                
                    required property var modelData
                    required property int index
                    width:appList.width
                    implicitHeight:52
                    property string appId:modelData.id
                    
                    radius:2
                    color:index ===appList.currentIndex?Theme.colorBlueBGHover:"transparent"
                    
                    property bool isPinned: pinned.includes(modelData.id)
                    Image {
                        id:icon
                        anchors {
                            left:parent.left
                            top:parent.top
                            leftMargin: 8
                            topMargin:8
                        }
                        width:36
                        height:36
                        source: Quickshell.iconPath(modelData.icon,true)||Quickshell.iconPath("application-x-executable")
                       smooth: true
                    } 
                    
                    StyledText {
                        text:modelData.name
                        font.pixelSize:18
                        font.weight:600
                        elide:Text.ElideRight
                        anchors {
                            topMargin:8
                            leftMargin:8
                            rightMargin:8
                            left:icon.right
                            top:parent.top
                            right:pin.left
                        }
                    }
                    StyledText {
                        elide:Text.ElideRight
                        anchors {
                            left:icon.right
                            bottom:parent.bottom
                            right:pin.left
                            leftMargin:8
                            bottomMargin:6
                            rightMargin:8
                        }
                        visible:modelData.comment !== undefined
                        text:modelData.comment||""
                    }
                    MouseArea {
                        hoverEnabled:true
                        anchors.fill:parent
                        cursorShape: Theme.mouseHand
                        id:m
                        onHoveredChanged: {
                
                            if(m.containsMouse) {
                                appList.currentIndex=index
                            }
                        }
                        onClicked: {
                            openApp(modelData.id)
                            console.log("total click")
                        }
                    }
                    Button {
                        width:24
                        height:24
                        id:pin
                        background:Rectangle{color:"transparent"}
                        anchors {
                            top:parent.top
                            right:parent.right
                            rightMargin:14
                            topMargin:14
                        }
                        onClicked: {
                            
                            if(isPinned && pinned.length < 1) {
                                
                                return 
                            }
                            root.updatePinned(modelData.id, !isPinned);
                            //pinCheck.reload()
                            
                        }
                        SVGIcon {
                        
                        iconName:isPinned?"pin--filled":"pin"
                        size:24
                    }
                    HH{}
                    }
                    
                
            
        
        }
        }

        
   
    }
    
    
    
    
 
}