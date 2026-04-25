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
          
            Component.onCompleted: {
                ShellContext.panelRefs.set("LAUNCHER_MENU",launcherPanel)
                if (this.WlrLayershell != null) {
                    console.log("asdf")
                     this.WlrLayershell.layer = WlrLayer.Overlay;
                }
            }
            anchors {
                left:true
                top:true
                bottom:true
                right:true
            }
            color:"transparent"

            Rectangle {
            anchors.fill:parent
            color:"transparent"
           MouseArea {
                anchors.fill:parent
          
                onClicked: {
                    console.log("asdf")
                    ShellContext.openWindow = ""
                    ShellContext.trayButton = null
                    ShellContext.launcherMenuBackSlug=""
                }
            
             
            }
          }
          
             
            Loader {
            
                focus:true
                anchors.centerIn:parent
                sourceComponent:{
                    if(ShellContext.launcherMenuSlug.length < 1 ) return blank
                    if(ShellContext.launcherMenuSlug == "apps") return appMenu
                    if(ShellContext.launcherMenuSlug == "wallpaper") return wallpaperMenu
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
            Component {
                id:wallpaperMenu
                WallpaperMenu{}
            }
            



            
        }
        
 
   
    
}