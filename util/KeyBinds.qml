import Quickshell.Io
import QtQuick
import Quickshell
 import Quickshell.Hyprland
Item{
    id: keybinds
    IpcHandler {
        target: "keybinds"
        function cycleWindows(direction:string) {
            const allClients = []
            Hyprland.workspaces.values.forEach(w=> {
                w.toplevels.values.forEach(l => {
                    allClients.push({
                        isActive: l.activated,
                        level:l
                    })
                })
            })

            const activeIndex = allClients.findIndex(t=>t.isActive === true);
            let nextWindow = activeIndex+1
            if(activeIndex === allClients.length - 1) {
                nextWindow = 0
            }
            if(direction == "prev") {
                nextWindow = activeIndex - 1
                if(activeIndex === 0) {
                    nextWindow = allClients.length - 1
                }
            }
            allClients[nextWindow].level.wayland.activate()
            
        }
    }
}
