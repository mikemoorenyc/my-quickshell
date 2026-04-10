import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
RowLayout {
    property var activeApps: {
        var apps = []
        ToplevelManager.toplevels.values.forEach((e)=> {
            if(!apps.includes(e.appId)) {
                apps.push(e.appId)
            }
        })

        return apps
    }
    spacing:0
    id:appRow
    Repeater {
        visible:activeApps.length
        model:activeApps
        AppIcon {
            required property var modelData
            appId:modelData
        }
        
     
           
                
    }
 
             
    
       
    

 
}