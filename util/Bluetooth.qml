pragma Singleton

import Quickshell
import Quickshell.Bluetooth


Singleton {

    readonly property var dAdapter: Bluetooth.defaultAdapter
    readonly property var connectedDevices: dAdapter?.devices?.values

    readonly property bool isConnected: {
        if(!connectedDevices) return false; 
        let connected = false
        for (var i = 0; i < connectedDevices.length; i++)
            if(connectedDevices[i].state === 1) {
                connected = true
            } 
        return connected
    }


}