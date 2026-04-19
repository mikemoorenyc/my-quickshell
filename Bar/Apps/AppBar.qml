import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.util
RowLayout {
    id:appRow
    spacing:4
    Repeater {
        model:ScriptModel {
            values: Hyprland.workspaces.values.map(m=>m)
        }
        required property var modelData
        Workspace {
            workspace:modelData
        }
    }
    
  
    /*
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
 

*/ 
}