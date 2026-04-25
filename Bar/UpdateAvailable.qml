import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets
import Quickshell.Io
import QtQuick.Layouts

///home/admin/.cache/arch-updates
RowLayout {
    implicitHeight:updateButton.implicitHeight
    property bool isVisible:false
    visible:isVisible
    Rectangle {
        color:Theme.colorBorder
        width: 1
        height:24
        Layout.rightMargin:4
    }
    Button {
    id:updateButton
    readonly property var theme: Theme
    implicitHeight:48
    implicitWidth:36
    hoverEnabled:true
    onClicked: {
            runUpdates.running = true
            ShellContext.openWindow =""
        }
    
    
    HH{id:mouseArea
    onHoveredChanged: {
            if(this.hovered) {
                ShellContext.toolTipState = "hovering"
                ShellContext.toolTipText = "There are updates available"
                ShellContext.toolTipAnchor = updateButton
                ShellContext.currentToolTipPanel="BAR_WINDOW"

            } else {
                ShellContext.toolTipState = "idle"

            }
        }
    
    }
    FileView {
        id:updatesAvail
        path:"/home/admin/.cache/arch-updates"
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
        onLoaded: {
      
            if(parseInt(updatesAvail.text()) > 10) {
            isVisible = true
        } else {
            isVisible = false
        } 
        }
    }
    
    Process {
        id:runUpdates
        running:false
        command: ["/home/admin/.config/ags/scripts/arch-updaterunner.sh"]
    }
    Process {
        id:recheckUpdates
        running:false
        command: ["/home/admin/.config/ags/scripts/arch-check-updates.sh"]
    }

    background:Rectangle {
        color:"transparent"
    }  
    
    font.family: theme.fontIcon
    font.pixelSize:24
    visible:isVisible
    palette.buttonText: theme.colorBG
    Rectangle {
        color:mouseArea.hovered?theme.colorYellowBGHover:theme.colorYellowBG
        radius:Theme.buttonRadius
        anchors {
            fill:parent
            topMargin:theme.marginButton
                bottomMargin:theme.marginButton
        }

    }
    SVGIcon {
        anchors.centerIn:parent
        iconName:"renew"
        iconColor: Theme.colorTextDark
      


    }
    
    Component.onCompleted: {
        runUpdates.exited.connect(()=> {
            recheckUpdates.running=true
        })
    }
}
}