import QtQuick.Layouts
import QtQuick // for Text
import QtQuick.Controls
import qs.util

   

    
    RowLayout {


         function timeString():string {
            const d = new Date();
            return Qt.formatDateTime(d.toString(),"hh:mmAP")
         }
         function dateString():string {
        
            const d = new Date();
            return Qt.formatDateTime(d.toString(),"MM/dd/yy")
         }
         Timer {
			running: true
			repeat: true
			interval: 1000 * 60

			onTriggered: {
                date = dateString()
                time=timeString()
            }
	    }

         
         property string time: timeString()
         property string date: dateString()
      
        layoutDirection: Qt.RightToLeft
        spacing:theme.marginButton
        
        
       
        Rectangle {
            width:62
            height:34
            color:"transparent"
            Layout.alignment: Qt.AlignRight
             StyledText {
                
                text:time
                font.pixelSize:13       
      
                lineHeight:.5
                height:12
          

                anchors {
                    top:parent.top
                    right:parent.right
                }

                
            }
            StyledText {
     
                font.pixelSize:13
                lineHeight:1
               
             
           
          
                text:date
                Layout.alignment: Qt.AlignRight
                 anchors {
                    bottom:parent.bottom
                    right:parent.right
                }
         
            }
        }
        Rectangle {
            color:theme.colorBorder
            width:1
            height:24
        }
 
   
        
}
