import Quickshell 
import qs.util
import QtQuick 
import QtQuick.Controls
import Quickshell.Io
import QtQuick.Layouts

Scope {
    id:launcherEnv
    IpcHandler {
        target: "launcherEnv"
        function setMenu(value:string) {
            
            if(value == "none") {
                ShellContext.launcherMenuSlug=""
                ShellContext.openWindow=""
                return 

            }
            const split=value.trim().split("--");
            if(split[1]) {
                ShellContext.launcherMenuBackSlug = split[1]
            }
            ShellContext.openWindow="LAUNCHER_MENU"
            ShellContext.launcherMenuSlug=split[0]
 
            
        }
    }
   
        PanelWindow {
            focusable:true
            visible: ShellContext.launcherMenuSlug.length > 1 && ShellContext.openWindow=="LAUNCHER_MENU"
            id:launcherPanel
            anchors {
                left:true
                top:true
                bottom:true
                right:true
            }
            color:"transparent"
            
            Component.onCompleted: {
                ShellContext.panelRefs.set("LAUNCHER_MENU",launcherPanel)
            }
          Rectangle {
            anchors.fill:parent
            color:"transparent"
           MouseArea {
                anchors.fill:parent
                z:1
                onClicked: {
                    console.log("clicked")
                    ShellContext.openWindow = ""
                    ShellContext.trayButton = null
                }
            
             
            }
          }
             
            Loader {
                z:2
                focus:true
                anchors.centerIn:parent
                sourceComponent:{
                    if(ShellContext.launcherMenuSlug.length < 1 ) return blank
                    if(ShellContext.launcherMenuSlug == "apps") return appMenu
                    return generalMenu
                }
                
            }
            Component {
                id:blank
                Rectangle{}
            }
            Component {
                id:generalMenu
                GeneralMenu{}
            }
            Component {
                id:appMenu
                AppMenu{}
            }



            
        }
 
   
    
}