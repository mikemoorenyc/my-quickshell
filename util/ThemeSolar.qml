pragma Singleton

import Quickshell
import QtQuick
// Yoink this from Caelestia
Singleton {
    //FONTS
    property string fontSans: "IBM Plex Sans"
    property string fontMono: "IBM Plex Mono"
    property string fontIcon: "Roboto Mono"

    //COLORS
    property string colorBG: "#002b36"
    property string colorShell: "#073642"
    property string colorShellHover: "#586e75"
    property string colorShellHoverLight: "#657b83"
    property string colorFG: "#fdf6e3"
    property string colorFGDim: "#93a1a1"
    property string colorLightBG: "#eee8d5"
    property string colorTextDark: "#002b36"
    
    property string colorBorder: '#586e75'
    property string colorBorderBright: "#eee8d5"
    
    property string colorYellowBG: '#b58900'
    property string colorYellowBGHover: '#916e00'
    property string colorYellowDim: '#6a5e31'
    property string colorYellow: "#b58900"

    property string colorGreyBG: "#657b83"
    property string colorGreyBGHover: "#586e75"

    property string colorGreen: "#859900"
    property string colorGreenBG: "#859900"
    property string colorGreenBGHover: "#6a7a00"
    property string colorGreenDim: "#386a47"
    property string colorRed: "#dc322f"
    property string colorRedBG: "#dc322f"
    property string colorRedBGHover: "#b02826"
    property string colorRedDim: "#874f4a"
    property string colorBlue: "#268bd2"
    property string colorBlueBG: "#268bd2"
    property string colorBlueBGHover: "#1e6fa8"
    property string colorBlueDim: "#46618c"

    //RADIUS
    property int buttonRadius: 2

    //SPACING
    property int marginButton: 8
    property int widthButton: 32
    property int heightButton:48

    property var mouseHand: Qt.PointingHandCursor


    function toggleTheme() {
        colorFG = "red"
        colorBorder = "yellow"
    }
    



}