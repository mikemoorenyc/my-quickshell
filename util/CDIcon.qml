//import Qt5Compat.GraphicalEffects
import QtQuick // for Text
import qs.util

Item {
    property string iconName
    property string iconColor
    property int size: 18

    readonly property string inIconColor: iconColor||Theme.colorFG

    width:size 
    height:size + 2
    FontLoader {
        id:materialIcon
        source:Qt.resolvedUrl("../assets/Material_Symbols_Sharp/MaterialSymbolsSharp-VariableFont_FILL,GRAD,opsz,wght.ttf")
    }
    Text {
        
        font.family:materialIcon.font.family
        font.pixelSize:size
        text: iconName
   
        anchors {
            left:parent.left
            top:parent.top
        }
        color:inIconColor
        lineHeight:size
    }
}
/*assets/Material_Symbols_Sharp/MaterialSymbolsSharp-VariableFont_FILL,GRAD,opsz,wght.ttf
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
*/

