import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Wayland
import qs.util
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
    Component.onCompleted: {
        ShellContext.appContainer = appRow
        ShellContext.previewAnchorX = appRow.mapToItem(null,0,0).x
    }
    onXChanged :{
     
        ShellContext.previewAnchorX = appRow.mapToItem(null,0,0).x
        ShellContext.recalculate()
    }
    Repeater {
        visible:activeApps.length
        model:activeApps
        AppIcon {
            required property var modelData
            appId:modelData
        }
        
     
           
                
    }
 
 
       
    

 
}