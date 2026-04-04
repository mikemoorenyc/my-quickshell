pragma Singleton

import Quickshell

// Yoink this from Caelestia
Singleton {
    //FONTS
    property string fontSans: "IBM Plex Sans"
    property string fontMono: "IBM Plex Mono"
    property string fontIcon: "Roboto Mono"

    //COLORS
    property string colorShell: "#073642"
    property string colorFG: "#fdf6e3"
    property string colorLightBG: "#93a1a1"
    property string colorFGDim: "#eee8d5"
    property string colorBG: "#002b36"
    property string colorYellowDim: '#916e00'
    property string colorYellow: "#b58900"
    property string colorBorder: "#586e75"
    property string colorBorderDark: "#073642"
    property string colorGreen: "#859900"
    property string colorRed: "#dc322f"
    property string colorRedDim: "#b02826"
    property string colorBlue: "#268bd2"
    property string colorBlueDim: "#1e6fa8"

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