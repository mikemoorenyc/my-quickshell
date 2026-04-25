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
    property string colorBG:"#262626"
    property string colorShell: "#393939"
    property string colorShellHover: "#474747"
    property string colorShellHoverLight: "#6f6f6f"
    property string colorFG: "#f4f4f4"
    property string colorFGDim: "#a2a2a2"
    property string colorLightBG: "#c6c6c6"
    property string colorTextDark: "#161616"
    
    property string colorBorder: '#525252'
    property string colorBorderBright: "#c6c6c6"
    
    property string colorYellowBG: '#f1c21b'
    property string colorYellowBGHover: '#ddaf0a'
    property string colorYellowDim: '#6a5e31'
    property string colorYellow: "#f1c21b"

    property string colorGreyBG: "#6f6f6f"
    property string colorGreyBGHover: "#5e5e5e"

    property string colorGreen: "#42be65"
    property string colorGreenBG: "#24a148"
    property string colorGreenBGHover:"#229944"
    property string colorGreenDim: "#386a47"
    property string colorRed: "#ff8389"
    property string colorRedBG: "#da1e28"
    property string colorRedBGHover: "#ba1b23"
    property string colorRedDim: "#874f4a"
    property string colorBlue: "#78a9ff"
    property string colorBlueBG: "#0f62fe"
    property string colorBlueBGHover: "#0353e9"
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