import Quickshell
import QtQuick
 import Quickshell.Wayland 
 import QtQuick.Layouts

ColumnLayout {
     property var appLayer
    property int itemCount
    property int itemIndex
    property bool isFirst:itemIndex === 0
    property bool isLast:itemIndex === itemCount - 1
    Rectangle {
        width:parent.implicitWidth
        color:isFirst?"blue":"red"
        height:t.implicitHeight
        Text {
        id:t
        anchors.left:parent.left
        text:itemIndex+appLayer.title
    }
   
    }
    spacing:0
Rectangle {
    //Max size 250 x 140
    color:"blue"
    id:imgContainer
    
    ScreencopyView {
        id:img
        anchors {
            top:parent.top
            right:parent.right
            bottom:parent.bottom
            left:parent.left
        }
        captureSource: appLayer
        anchors {
            leftMargin: isFirst?8:0
            rightMargin:isLast?8:0
            bottomMargin:8
        }
        width:imgContainer.width
    }
    height:140 
    
    width: {
        const imgW = img.sourceSize.width
        const imgH = img.sourceSize.height
        if(imgH<1||imgW<1) return 250
        if(imgW<=imgH) return 250
        const scale = 140/imgH
        const newW = imgW * scale
       return newW<50 ?140 : newW
    }
    
    
}
}
