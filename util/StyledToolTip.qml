import QtQuick // for Text
import Quickshell
import qs.util
import QtQuick.Controls
Item {
    id:ttHover
    property string text
    property string panel
    Timer {
        id:shower
        interval:500
        running:false
        onTriggered: {
            if(ttHover.hovered) {
                ShellContext.toolTipAnchor = ttHover.parent
                ShellContext.toolTipText = text
                ShellContext.currentToolTipPanel =panel
            }
        }
    }
    HoverHandler {
    
    
    onHoveredChanged: {
        console.log("change")
        shower.running = false
        if(!hovered) {
            ShellContext.toolTipAnchor = null
            ShellContext.toolTipText = ""
            ShellContext.currentToolTipPanel =""
        } else {
            shower.running = true 
        }
    }
}
}