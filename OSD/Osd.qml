import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Widgets
import QtQuick.Layouts
import qs.util
import Quickshell.Services.Pipewire
Scope {
    property bool shouldShowOsd: false
    id:root 

    PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink,Pipewire?.defaultAudioSink?.audio ]
	}

	Connections {
        
		target: Pipewire.ready?Pipewire?.defaultAudioSink?.audio:null

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
        
	}
    Connections {
		target: Pipewire.ready?Pipewire?.defaultAudioSink?.audio:null

		function onMutedChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
        
	}




	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}


    LazyLoader {
        active:shouldShowOsd
        PanelWindow {
        anchors.bottom: true
        margins.bottom: screen.height / 8
        exclusiveZone: 0

        implicitWidth: 320
        implicitHeight: 50
        color: "transparent"

        // An empty click mask prevents the window from blocking mouse events.
        mask: Region {}
        Rectangle {
            anchors.fill:parent
            color:Theme.colorFGDim
            radius:Theme.buttonRadius
            border {
                width:2
                color:Theme.colorBorder
            }
            CDIcon {
                size:32
                id:speakerIcon
                iconName: Sound.speakerIcon
                iconColor:Theme.colorBG
                anchors {
                    left: parent.left
                    verticalCenter:parent.verticalCenter
                    leftMargin:Theme.marginButton + 2
                }
            }
            Rectangle {
                color:"transparent"
                id:volumeTextContainer
                implicitWidth:40;
                implicitHeight:volumeText.implicitHeight
                anchors {
                    right:parent.right
                    verticalCenter:parent.verticalCenter
                    rightMargin:Theme.marginButton+2
                }
                Text {
                    color: Theme.colorBG
                    font.pixelSize: 18
                    font.family:Theme.fontSans
                    anchors.right:parent.right
                    id:volumeText
                    text:Sound.speakerVolume
                }
            }
            Rectangle {
                color:Theme.colorBorder
                implicitHeight:8
                radius:Theme.buttonRadius
                anchors {
                    left:speakerIcon.right
                    right: volumeTextContainer.left
                    verticalCenter:parent.verticalCenter
                    leftMargin:Theme.marginButton
                }
                Rectangle {
                    color:Theme.colorShell
                    radius:Theme.buttonRadius
                    anchors {
                        left:parent.left
                        top:parent.top
                        bottom:parent.bottom
                    }
                    implicitWidth: {
                        if(!Sound.defaultAudio) {
                            return 0
                        }
                        return Math.floor(parent.width*Sound.defaultAudio.volume)
                    }
                }
            }
        }

    }
    }

}