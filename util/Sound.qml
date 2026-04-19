pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    PwObjectTracker {
		objects: [Pipewire, Pipewire.defaultAudioSink, Pipewire.defaultAudioSink, Pipewire.defaultAudioSource,Pipewire.defaultAudioSource]
	}
    readonly property var defaultSpeaker: Pipewire.ready?Pipewire.defaultAudioSink:null
    readonly property var defaultAudio: Pipewire.ready&&defaultSpeaker?defaultSpeaker.audio:null
    readonly property bool speakerMuted: defaultAudio?defaultAudio.muted:false
    readonly property int speakerVolume: defaultAudio?Math.floor(defaultAudio.volume * 100):0
    readonly property var defaultSource: Pipewire.ready?Pipewire?.defaultAudioSource:null
    readonly property var defaultMic: Pipewire.ready&&defaultSource?defaultSource?.audio:null
    readonly property bool micMuted : {
        if(!Pipewire.ready) return false 
        if(!defaultMic) return false 
        return defaultMic?.muted
    }
 



    readonly property var speakerIcon : {
        if(speakerMuted) return "volume-mute"
        if(speakerVolume === 0) {
            return "volume-level-0"
        }
        if(speakerVolume < 50) {
            return "volume-level-1"
        }
      
        return "volume-level-2"
    }

}