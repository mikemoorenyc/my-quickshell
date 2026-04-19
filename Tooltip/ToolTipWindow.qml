import Quickshell // for PanelWindow
import qs.util
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Io

PanelWindow {
    id:ttWindow
    exclusionMode:ExclusionMode.Ignore
    exclusiveZone:0
     WlrLayershell.layer: WlrLayer.Overlay
    mask: Region {}
    anchors {
        left:true
        right:true
        bottom:true
        top:true
    }
    color:"transparent"
    implicitHeight:50
    visible:  ShellContext.toolTipState == "activated" && panelX !== 0 && panelY !== 0 
    
    property int checks: 0
    property int panelX:0
    property int panelY:0
    property var monitor 
    property string arrowAlign:''
    


    Process {
        id:monitors 
        running: false 
        command: [ "sh", "-c", "hyprctl monitors -j"]
        stdout: StdioCollector {
            onStreamFinished: {
                monitor = JSON.parse(this.text)[0]
      
            }
        }
    }

    function evaluatePosition() {
       arrowAlign=""
        const panel = ShellContext.panelRefs.get(ShellContext.currentToolTipPanel)

        const reserveBottom = monitor?monitor.reserved[3]:0
        if(reserveBottom < 1) return 
        

             
       
        const pW = panel.implicitWidth
     
        let pLeftPos=0
        if(panel.anchors.left) {
         
            pLeftPos = (panel.margins.left||0) + ShellContext.toolTipAnchor.mapToItem(null,0,0).x
        } else if(panel.anchors.right) {

            pLeftPos = (screen.width) - (panel.implicitWidth + (panel.margins.right || 0)) + ShellContext.toolTipAnchor.mapToItem(null,0,0).x

        
        }
        let pTopPos=0
        if(panel.anchors.top) {
            pTopPos = (panel.margins.top||0)+ShellContext.toolTipAnchor.mapToItem(null,0,0).y
        } else if(panel.anchors.bottom) {
          
           
            pTopPos = (screen.height) -(
                (panel.margins.bottom||0) + panel.implicitHeight +reserveBottom
            ) + ShellContext.toolTipAnchor.mapToItem(null,0,0).y
            
           
           
        }

        if(ShellContext.currentToolTipPanel == "BAR_WINDOW") {
            pTopPos = screen.height - reserveBottom
        }
        
        panelX = pLeftPos - (( toolTipContainer.implicitWidth - (ShellContext.toolTipAnchor.implicitWidth|| ShellContext.toolTipAnchor.width))/2)
        panelY = pTopPos - (toolTipContainer.implicitHeight + 4)
     
        
        if(panelX < 16) {
            panelX = pLeftPos
            arrowAlign="left"
        }
        //Check if going off right side
        if (panelX + toolTipContainer.implicitWidth > screen.width - 16) {
            panelX = (pLeftPos - toolTipContainer.implicitWidth) + (ShellContext.toolTipAnchor.implicitWidth|| ShellContext.toolTipAnchor.width)
            arrowAlign="right"
        }
        if(panelX < 0) {
            panelX = pLeftPos
            arrowAlign="left"
        }
        
      



    }
    Timer {
        id:checker
        running:false
        interval:500
        repeat:true
        onTriggered: {
            
          
            if(ShellContext.toolTipState == "idle") {
                checker.running = false
                ttWindow.visible = false  
                return 
            }
            if(ShellContext.toolTipState == "hovering") {
                monitors.running = true
                
                ttWindow.visible = true
            }
            monitors.running = true 
            evaluatePosition()
            ShellContext.toolTipState == "activated"
        }
    }

    Connections {
        target:ShellContext
        ignoreUnknownSignals:true

        
        function onToolTipStateChanged() {
        
            if(ShellContext.toolTipState == "idle") {
   
                ttWindow.visible = false 
                checker.running = false
            }
            if(ShellContext.toolTipState == "hovering") {
                checker.running = true
            }
        }

    }
    Rectangle {
        implicitHeight:ttt.implicitHeight
        implicitWidth:ttt.implicitWidth
        id:toolTipContainer
        color:Theme.colorFG
        radius:Theme.buttonRadius
        anchors {
            top:parent.top
            left:parent.left
            leftMargin:panelX
            topMargin:panelY
        }
        border {
            width:1
            color:Theme.colorBorder
        }
        visible:panelX!==0 
        component Arrow: Rectangle {
            id:arrow
            width:10
            height:10
            color:Theme.colorFG
            border {
                width:1
                color:Theme.colorBorder
            }
            anchors.bottom:parent.bottom
            anchors.bottomMargin:-4
            
            rotation:45
            property string a:""
        }
        Arrow {
            a:arrowAlign
            anchors{
                horizontalCenter:parent.horizontalCenter
            }
            visible:a.length < 1

            
            
        }
        Arrow {
            a:arrowAlign
            anchors{
                left:parent.left
                leftMargin: 10
            }
            visible:a == "left"

        }
        Arrow {
            a:arrowAlign
            anchors{
                right:parent.right
                rightMargin: 10
            }
            visible:a == "right"

        }
        Rectangle {
            color:Theme.colorFG
            
            height:20
            anchors {
                bottom:parent.bottom 
                left:parent.left
                right:parent.right
                leftMargin:1
                rightMargin:1
                bottomMargin: 1
            }

        }
        StyledText {
            
            id:ttt
            text:ShellContext.toolTipText
            color:Theme.colorTextDark
            font.pixelSize:14
            bottomPadding:4
            topPadding:4
            leftPadding:8
            rightPadding:8
        }
       
    }
}