import Quickshell // for PanelWindow
import qs.util
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls

Scope {
    LazyLoader {
        active:ShellContext.openWindow == "PREVIEW_WINDOW"
        PanelWindow {
    id: winder
   
    property int leftAnchor: 55
    property var apps:[]
    property int leftPos: 0
    property string activeLevel : Hyprland.activeToplevel.address
    property string currentLevel:""
    property string addr: ShellContext.hoveredAddress
    property bool hovering: false
    onHoveringChanged: {
        ShellContext.previewHovering = hovering
        turnOff.running = hovering
    }
    Timer {
        id:turnOff
        interval:250
        onTriggered: {
            if(ShellContext.appIconHovering || ShellContext.previewHovering) {
                return 
            }
            ShellContext.openWindow =""
            ShellContext.hoveredAddress=""
        }
        running:false
    }
    
   
    visible: ShellContext.openWindow == "PREVIEW_WINDOW"
    anchors {
        bottom:true
        left:true
        right:true
        top:true
    }
     MouseArea {
        anchors.fill:parent
        onClicked:{
            ShellContext.openWindow=""
        }
    }
    Timer {
        id:updater
        interval:500
        onTriggered: {
            updateApps()
            setLeftPos()
        }
        running:false
    }
    onVisibleChanged: {
        if(!visible) {
            ShellContext.openWindow =""
            apps = []
        } else {
            updateApps()
        }
        if(!visible) return 
        setLeftPos()
    }
    function setLeftPos() {
        const icon = ShellContext.iconRefs.get(ShellContext.hoveredAddress)
        if(!icon) return 
        leftPos = icon.mapToItem(null,0,0).x - ( (250-30) / 2 )
    }
    onAddrChanged: {
        setLeftPos()
    }
    Timer {
        id:activeChangeCheck
        interval:500
        running:false
        onTriggered: {
            currentLevel = Hyprland.activeToplevel.address
        }
    }
    onActiveLevelChanged : {
        
        if(currentLevel !== Hyprland.activeToplevel.address && currentLevel.length > 0) {
           winder.visible = false 
        }
       console.log(currentLevel == Hyprland.activeToplevel.address,"first check")
       activeChangeCheck.running=true
 
        
    }
    function updateApps () {
        apps = Hyprland.toplevels.values.map(m=> {
                const add = m.address
            
                return {
                    way: ShellContext.waylandRefs.get(add),
                    address:add,
                    icon: ShellContext.iconRefs.get(add)
                }
            })
    }
    color:"transparent"
    
    RowLayout {
        id:previewWrapper
        anchors {
            bottom:parent.bottom
            left:parent.left
            leftMargin:leftPos
            bottomMargin:4
        }
        spacing:0
        Repeater {
            model:apps
            property var modelData
            Item {
                implicitWidth:imgLoader.implicitWidth
                implicitHeight:imgLoader.implicitHeight
                visible:ShellContext.hoveredAddress == modelData.address && modelData.way!==undefined
                Component {
                    id:rect
                    Rectangle{color:"transparent"}
                }
                Component {
                    id:mainImg
                    ColumnLayout {
                        width:250
                        spacing:0
                        id:previewContainer
                        visible:ShellContext.hoveredAddress == modelData.address && modelData.way!==undefined
                        property bool hovering:false 
                        Rectangle {
                            radius:2
                            height:48
                            Layout.fillWidth:true
                            color:winder.hovering?Theme.colorShellHover:Theme.colorShell
                            border {
                                width:2
                                color: Theme.colorBorder
                            }
                            Rectangle {
                                anchors {
                                    fill:parent
                                    topMargin:8
                                }
                                color:Theme.colorBorder
                                height:8
                            }
                            Rectangle {
                                anchors {
                                    fill:parent
                                    leftMargin:2
                                    rightMargin:2
                                    topMargin:8
                                }
                                color:winder.hovering?Theme.colorShellHover:Theme.colorShell
                            }
                            Button {
                                id:header
                                
                                background:Rectangle{color:"transparent"}
                                anchors{
                                    top:parent.top
                                    bottom:parent.bottom
                                    left:parent.left
                                    right:m.hovered?closeButton.left:parent.right
                                }
                                onClicked: {
                                    modelData.way.activate()
                                    ShellContext.openWindow=""
                                }
                                Image {
                                    source: Quickshell.iconPath(modelData.way.appId,true)||Quickshell.iconPath("application-x-executable")
                                    width:18
                                    height:18
                                    id:icon
                                    anchors {
                                        left:parent.left
                                        verticalCenter:parent.verticalCenter
                                        leftMargin:8
                                    }
                                }
                                StyledText {
                                    text:modelData.way.title
                                    elide:Text.ElideRight
                                    anchors {
                                        left:icon.right
                                        verticalCenter:parent.verticalCenter
                                        right:parent.right
                                    }
                                    leftPadding:8
                                    rightPadding:8
                                    verticalAlignment:Text.AlignVCenter
                                }

                                HH{}
                            }
                            Button {
                                id:closeButton
                                visible:m.hovered
                                width:32
                                height:32
                                background:Rectangle{
                                    color:mx.hovered?Theme.colorRedBGHover:"transparent"
                                    anchors.fill:parent
                                    border {
                                    width:1
                                    color:Theme.colorBorder 
                                }    
                                }
                                
                                anchors {
                                    right:parent.right
                                    verticalCenter:parent.verticalCenter
                                    rightMargin:8
                                }
                                SVGIcon {
                                    iconName:"close"
                                    anchors.centerIn:parent
                                    size:20
                                }
                                onClicked: {
                                    modelData.way.close()
                                    ShellContext.openWindow=""
                                }
                                HH{id:mx}
                            }
                            HH{
                                id:m
                                onHoveredChanged:{
                                    previewContainer.hovering = this.hovered
                                }
                            }

                        }
                        Button {
                            implicitWidth:250
                            implicitHeight: {
                                if(img.sourceSize.height<50) {
                                    return 140
                                }
                                const sH = img.sourceSize.height
                                const sw = img.sourceSize.width
                                const ratio = 250/sw
                                return sH * ratio
                            }
                            onClicked: {
                                modelData.way.activate()
                                ShellContext.openWindow=""
                            }
                            background:Rectangle {
                                border {
                                    width:2
                                    color:Theme.colorBorder
                                }
                                color:winder.hovering?Theme.colorShellHover:Theme.colorShell
                                radius:2
                            }
                            Rectangle {
                                anchors {
                                    fill:parent
                                    bottomMargin:8
                                    
                                }
                                color:Theme.colorBorder
                            }
                            Rectangle {
                                anchors {
                                    fill:parent
                                    leftMargin:2
                                    rightMargin:2
                                    bottomMargin:8
                                }
                                color:winder.hovering?Theme.colorShellHover:Theme.colorShell
                            }
                            ScreencopyView {
                                id:img
                                anchors {
                                    top:parent.top
                                    right:parent.right
                                    bottom:parent.bottom
                                    left:parent.left
                                    leftMargin:8
                                    bottomMargin:8
                                    rightMargin:8
                                }
                                captureSource: modelData.way
                        
                                anchors {
                                    leftMargin: isFirst?8:0
                                    rightMargin:isLast?8:0
                                    bottomMargin:8
                                }
                                width:250
                            }
                            HH{}
                        }
                    }
                    

                }
                Loader {
                    id:imgLoader
                    active:modelData.way!== undefined
                    sourceComponent: modelData!==undefined?mainImg:rect
                }
            }
            
            
                 
        }
            
            /*ColumnLayout {
                required property var modelData
                spacing:0
                width:250
                property bool hovering:false
                RowLayout {
                    Layout.leftMargin:8
                    Layout.rightMargin:8
                    Layout.fillWidth:true
                    spacing:0
                    Rectangle {
                        height:20
                        Layout.fillWidth:true
                        Text {
                            text:modelData.way.title
                        }
                    }
                }
            }*/
            HH{id:mi
                    onHoveredChanged: {
                        winder.hovering = this.hovered
                    }
    }
        }
        
   
    
}
    }
}