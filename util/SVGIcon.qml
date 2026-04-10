import qs.util
import QtQuick.Layouts
import QtQuick

import Qt5Compat.GraphicalEffects

Rectangle {
    property int size: 16
    property string iconColor:Theme.colorFG
    property string iconName:"apps"
    color:"transparent"

    width: size
    height:size
    Image {
        id:iconImage
        source: `/home/admin/.config/my-quickshell/icons/${iconName}.svg`
        sourceSize {
            width: size
            height:size
        }
        width:size
        height:size
        anchors.centerIn: parent
        smooth: true
        visible: false
    }
    ColorOverlay {
        anchors.fill: iconImage
        source: iconImage
        color: iconColor
    }
}