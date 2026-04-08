pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import QtQuick // for Text

Singleton {
    property int strength: 0
    property bool vpn :false
    property bool connected: false 
    property string iconName: "wifi_off"
    property string ssid:"No network"

    Process {
        id:fetchNetworkData
        running:true
        command: ["/home/admin/.config/my-quickshell/scripts/network-test.sh"]
        stdout: StdioCollector {
        // Listen for the streamFinished signal, which is sent
        // when the process closes stdout or exits.
            onStreamFinished:  {
                var parsedData = JSON.parse(this.text)
          
                strength = parsedData.strength
                vpn = parsedData.vpn
                connected= parsedData.connected
                iconName = iconPicker()
                ssid = parsedData.ssid || "No network"
       

            } 
        }
    }
    function iconPicker() {
        if(!connected) {
            return "wifi_off"
        }
        if(vpn) {
            return "wifi_password"
        }
        if(strength > 2) return "wifi"
        return `wifi_${strength}_bar`
    }

    Timer {
        id: networkTester
        running: true
        repeat: true
        interval:1000*5
        onTriggered: {
            fetchNetworkData.running = true
        }
    }

}