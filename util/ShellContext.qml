pragma Singleton

import Quickshell


Singleton {
    property bool trayOpen: false
    property int trayPosition:259
    property var trayButton
    property var trayContentRef
    property string openWindow: ""

    //PREVIEW WINDOW
    property string previewAppId
    property var previewAnchor
}