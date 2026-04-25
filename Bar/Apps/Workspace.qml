import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.util
import QtQuick.Controls
import Quickshell
Item {
    property int size:40
    property var workspace
    property var isEmpty :workspace.toplevels.values.length <1
    property var isActive: workspace.focused
    onIsActiveChanged: {
        ShellContext.openWindow=""
    }
    implicitWidth:load.implicitWidth
    implicitHeight:load.implicitHeight
    component ButtonBackground: Rectangle {
        property bool hovering
   
        id:buttonBackground
        anchors.fill:parent
        border {
            width:isActive?2:1
            color:Theme.colorBorder
        }
        color:hovering||isActive?Theme.colorShell:"transparent"
        radius:2
    
    }
    
    Component {
        id:hasApps
        Item {
            width:appButton.implicitWidth
            height:size
            property bool hovering
            id:btnContainer
            ButtonBackground{
                hovering:btnContainer.hovering
            }
            
            RowLayout {
            id:appButton
            height:size
            
            spacing:0
            Button {
                
                Layout.fillHeight:true
                implicitWidth:20
                background:Rectangle{color:"transparent"}
                hoverEnabled :true
                onClicked:{
                    ShellContext.openWindow=""
                if(workspace.active) return 
                workspace.activate()
            }
               
                StyledText {
                    font.pixelSize:16
                    text:workspace.id
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left:parent.left
                        leftMargin: 8
                        
                    }
                }
                HH{}
    
                
            }

            Repeater {
                model: ScriptModel {
                    values: workspace.toplevels.values.map(m=>m)
                }
                
                Button {
                    required property var modelData
                    id:iconButton
                    background:Rectangle{color:"transparent"}
                    property var way : modelData.wayland
                    hoverEnabled:true
                    implicitHeight:size
                    implicitWidth: 30
                    Component.onCompleted: {
                        ShellContext.iconRefs.set(modelData.address,iconButton)
                 
                    }
                    Component.onDestruction: {
                      
                        ShellContext.iconRefs.delete(modelData.address)
                        ShellContext.waylandRefs.delete(modelData.address)
                    }
                    onWayChanged: {
                        if(!way) return 
                        ShellContext.waylandRefs.set(modelData.address,way)
                    }
                    Timer {
                        id:previewOpener
                        interval:500
                        onTriggered: {
                            if(ShellContext.previewHovering) {
                                return 
                            }
                            if(iconButton.hovered) {
                                 ShellContext.hoveredAddress = modelData.address 
                                 ShellContext.openWindow = "PREVIEW_WINDOW"   
                                 return 
                            } else {
                                if(ShellContext.hoveredAddress !== modelData.address) {
                                    return 
                                }
                                ShellContext.hoveredAddress = ""
                                ShellContext.openWindow = ""
                                return 
                            }

                           
                        }
                        running:false
                    }
                    onHoveredChanged: {
                        ShellContext.appIconHovering = this.hovered
                        previewOpener.running = false
                        if(!hovered) {
                            if(ShellContext.openWindow =="PREVIEW_WINDOW") {
                                previewOpener.running = true
                                return
                            } 
                      
                            previewOpener.running = false
                        } else {
                            if(ShellContext.openWindow =="PREVIEW_WINDOW") {
                                ShellContext.hoveredAddress = modelData.address 
                            }
                            previewOpener.running = true
                        }
                        
                    }


                 
                    onClicked: {
                        way.activate()
                        ShellContext.openWindow=""
                        //ShellContext.hoveredAddress = modelData.address
                        //ShellContext.openWindow = "PREVIEW_WINDOW"
                       // way.activate()
                    }
                   
                    Image {
                        anchors.centerIn:parent
                        width:22
                        height:22
                        sourceSize {
                            width:22
                            height:22
                        }
                        source: {
                            if(!way)return Quickshell.iconPath("application-x-executable")
                            return Quickshell.iconPath(way.appId,true)||Quickshell.iconPath("application-x-executable")
                        }
                    }
                    Rectangle {
                        visible: m.hovered||modelData.activated
                        
                        id:pip
                        width:modelData.activated?18:4
                        height:4
                        color:Theme.colorBlueBG
                        anchors {
                            top:parent.top
                            horizontalCenter:parent.horizontalCenter
                            topMargin:2
                        }
                    }
                    HH{id:m}
                }
            }

      



            Button {
                Layout.fillHeight:true
                hoverEnabled :true
                onClicked:{
                    ShellContext.openWindow=""
                if(workspace.active) return 
                workspace.activate()
            }
                implicitWidth:8
                background:Rectangle{color:"transparent"}
              HH{}
            }
            HoverHandler {
                onHoveredChanged: {
                    btnContainer.hovering = this.hovered
                }
                cursorShape:Qt.PointingHandCursor
            }
        }
        }
        
    }
    Component {
        id: emptyButton 
        Button {
            width: size
            height: size
            background:ButtonBackground{hovering:m.hovered}
            StyledText {
                anchors.centerIn:parent
                font.pixelSize:16
                text: workspace.id
            }
            onClicked:{
                ShellContext.openWindow=""
                if(workspace.active) return 
                workspace.activate()
            }
            HH{id:m}
        }
        

       
    }
    Loader {
        id:load
        sourceComponent:isEmpty?emptyButton:hasApps
    }
}