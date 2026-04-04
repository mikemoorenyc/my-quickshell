pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    PwObjectTracker {
		objects: [Pipewire.ready, Pipewire.defaultAudioSink, Pipewire.defaultAudioSink?.audio?.volume, Pipewire.defaultAudioSource,Pipewire.defaultAudioSource?.audio]
	}
    readonly property var defaultSpeaker: Pipewire.defaultAudioSink
    readonly property var defaultAudio: defaultSpeaker?defaultSpeaker.audio:null
    readonly property bool speakerMuted: defaultAudio?defaultAudio.muted:null
    readonly property int speakerVolume: defaultAudio?Math.floor(defaultAudio.volume * 100):-1
    readonly property var defaultSource: Pipewire?.defaultAudioSource
    readonly property var defaultMic: defaultSource?.audio
    readonly property bool micMuted : Pipewire.ready?defaultMic?.muted:false
 



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