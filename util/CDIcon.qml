import Qt5Compat.GraphicalEffects
import QtQuick // for Text
Image {
    id:cdIcon
    property string iconColor: Theme.colorFG
    property  int size: 16
    property string iconName:"apps"
    sourceSize {
        width:size
        height:size
    }
    source:`/home/admin/.config/my-quickshell/icons/${iconName}.svg`
    ColorOverlay {
        anchors.fill:parent
        source:parent
        color:iconColor
    }
}

