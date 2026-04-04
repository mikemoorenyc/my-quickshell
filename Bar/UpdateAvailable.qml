import QtQuick // for Text
import QtQuick.Controls
import "../util/"
import Quickshell.Widgets
import Quickshell.Io

///home/admin/.cache/arch-updates
Button {
    readonly property var theme: Theme
    implicitHeight:48
    implicitWidth:36
    hoverEnabled:true
    property bool isVisible:false
    

    FileView {
        id:updatesAvail
        path:"/home/admin/.cache/arch-updates"
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
        onLoaded: {
            checkUpdates()
        }
    }
    function checkUpdates() {
       

        if(parseInt(updatesAvail.text()) > 5) {
            isVisible = true
        } else {
            isVisible = false
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
        color:mouseArea.containsMouse?theme.colorYellow:theme.colorYellowDim
        radius:Theme.buttonRadius
        anchors {
            fill:parent
            topMargin:theme.marginButton
                bottomMargin:theme.marginButton
        }

    }
    CDIcon {
        anchors.centerIn:parent
        iconName:"reset"
        iconColor:theme.colorBG
    }
    MouseArea {
        anchors {
            fill:parent
        }
        hoverEnabled:true 
        id:mouseArea
        onClicked: {
            runUpdates.running = true
        }
        cursorShape:Qt.PointingHandCursor
    }
    Component.onCompleted: {
        runUpdates.exited.connect(()=> {
            recheckUpdates.running=true
        })
    }
}