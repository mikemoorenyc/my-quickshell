import QtQuick
import qs.util
import QtQuick.Layouts
StyledText {
    Layout.fillWidth:true
    maximumLineCount:1
    elide:Text.ElideRight
    color:Theme.colorFGDim
    font.pixelSize:13
    horizontalAlignment:Text.AlignHCenter
    font.family:Theme.fontSans

}