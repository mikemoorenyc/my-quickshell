import QtQuick // for Text
import QtQuick.Controls
import qs.util
import Quickshell.Widgets
import QtQuick.Layouts
import qs.Bar
import Quickshell.Io
import "../../util/weathersymbol.js" as WeatherUtil


BarButtonContainer{
    toolTipText:"Current weather"
    id:weatherButton
    property string temp:""
    property string wIcon:"weather-cloudy"
    FileView {
    id:weatherJSON
    path: "/home/admin/.cache/current-weather"
  // when changes are made on disk, reload the file's content
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
        updater(this.text())
    }
    blockLoading: true
    
  }
  isActive: ShellContext.openWindow == "WEATHER_WINDOW"
  
  click: () => {
    if(ShellContext.openWindow == "WEATHER_WINDOW") {
      ShellContext.trayButton=null
      ShellContext.openWindow=""
      return 
    }
    ShellContext.trayButton=weatherButton
    ShellContext.openWindow="WEATHER_WINDOW"
  }
  function updater(text):void {
    var data = JSON.parse(text);

    temp = Math.floor(data.current.temperature_2m)+"°"
  
    wIcon = WeatherUtil.symbolFetch(data.current.weather_code,data.current.is_day)
  }

  component ButtonText: StyledText {
    color: theme.colorFG
    font.pixelSize:14
    
    font.family:theme.fontMono
  }


    RowLayout {
        id:container
        spacing: theme.marginButton / 2
        anchors {
    
            horizontalCenter:parent.horizontalCenter
            verticalCenter:parent.verticalCenter
        }
        SVGIcon {
          iconName:wIcon
          size:16
        }
        ButtonText {
            text: temp
        }
        
         
        }

}

