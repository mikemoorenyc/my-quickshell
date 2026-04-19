pragma Singleton

import Quickshell


Singleton {
    property bool trayOpen: false
    property int trayPosition:259
    property var trayButton
    property int trayButtonX
    property int trayButtonW
    property var trayContentRef
    property string openWindow: ""

    //AllPanelRefs / TOOLTIP
    property var panelRefs : new Map()
    property string toolTipText:""
    property var toolTipAnchor
    property string currentToolTipPanel
    property string toolTipState:"idle"
    
    //PREVIEW WINDOW
    property string previewAppId
    property var previewAnchorX:0
    property var previewAnchorW
    property var appContainer
    property var appIcon
    property int leftAnchor : !appIcon?0:previewAnchorX + appIcon.x
    function recalculate() {
    
        leftAnchor = !appIcon?0:previewAnchorX + appIcon.x

    }
    property bool previewHovering:false
    property bool appIconHovering:false
    property var iconRefs : new Map()
    property var waylandRefs:new Map()
    property var hoveredAddress

    //LAUNCHER
    property string launcherMenuSlug:""
    property string launcherMenuBackSlug:""
    

    
    
}