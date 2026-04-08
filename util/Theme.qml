pragma Singleton

import Quickshell

// Yoink this from Caelestia
Singleton {
    //FONTS
    property string fontSans: "IBM Plex Sans"
    property string fontMono: "IBM Plex Mono"
    property string fontIcon: "Roboto Mono"

    //COLORS
    property string colorShell: "#3e3e3e"
    property string colorFG: "#cfcfcf"
    property string colorLightBG: "#a2a2a2"
    property string colorFGDim: "#a2a2a2"
    property string colorBG: "#292929"
    property string colorYellowBG: '#84763d'
    property string colorYellowDim: '#6a5e31'
    property string colorYellow: "#e0ce91"
    property string colorBorder: "#777777"
    property string colorBorderDark: "#4e4e4e"
    property string colorGreen: "#9ddeaf"
    property string colorGreenBG: "#468459"
    property string colorGreenDim: "#386a47"
    property string colorRed: "#ffbbb2"
    property string colorRedBG: "#a9635d"
    property string colorRedDim: "#874f4a"
    property string colorBlue: "#b3d1ff"
    property string colorBlueBG: "#5879af"
    property string colorBlueDim: "#46618c"

    //RADIUS
    property int buttonRadius: 2

    //SPACING
    property int marginButton: 8
    property int widthButton: 32
    property int heightButton:48


    function toggleTheme() {
        colorFG = "red"
        colorBorder = "yellow"
    }
    



}