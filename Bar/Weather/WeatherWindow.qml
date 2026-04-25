import qs.util
import QtQuick.Layouts
import QtQuick
import Quickshell
import Quickshell.Io
import "../../util/weathersymbol.js" as WeatherUtil
import QtQuick.Controls

Scope {
    LazyLoader {

        active: ShellContext.openWindow == "WEATHER_WINDOW"
        PanelContainer {
            id:weatherWindow 
            implicitWidth:weatherContent.width+4
            implicitHeight:weatherContent.implicitHeight+4
            property var current
            property var hourly
            anchors {
                right: true
                bottom: true
            }
            margins {
                right: 12
                bottom: 0
            }
            function updater(text):void {
                var data = JSON.parse(text);
                weatherWindow.current = data.current
                weatherWindow.hourly = data.hourly
                const nowHour = new Date().getHours() + 1

                const hourArray = []
                for (let i = 0; i < 24; i++) {
        
                        hourArray.push({
                            temperature_2m:weatherWindow.hourly.temperature_2m[nowHour+i],
                            is_day: weatherWindow.hourly.is_day[nowHour+i],
                            apparent_temperature: weatherWindow.hourly.apparent_temperature[nowHour+i],
                            weather_code:weatherWindow.hourly.weather_code[nowHour+i],
                            precipitation_probability :weatherWindow.hourly.precipitation_probability[nowHour+i],
                            precipitation:weatherWindow.hourly.precipitation_probability[nowHour+i],
                            time: Qt.formatDateTime(weatherWindow.hourly.time[nowHour+i],"hAP")
                        })
                }
                weatherWindow.hourly= hourArray

                //temp = Math.floor(data.current.temperature_2m)+"°"
            
                //wIcon = WeatherUtil.symbolFetch(data.current.weather_code,data.current.is_day)
            }
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
            ColumnLayout {
                id: weatherContent
                width: 260
                anchors.centerIn:parent
                spacing:0
                Component {
                    id:currentWeather
                    Rectangle {
                        width:weatherContent.width
                        height:110
                        color:Theme.colorBG
                        Rectangle {
                            color:Theme.colorBorder
                            height:1
                            anchors {
                                left:parent.left
                                bottom:parent.bottom
                                right:parent.right
                            }
                        }
                        SVGIcon {
                            id:icon
                            size:64
                            iconName:WeatherUtil.symbolFetch(current.weather_code,current.is_day)
                            anchors {
                                left:parent.left
                                top:parent.top
                                margins:16
                                topMargin:20
                            }
                        }
                        ColumnLayout {
                            spacing: -8;
                            anchors {
                                right:parent.right
                                top:parent.top
                                left:icon.right
                                leftMargin:18
                                topMargin:8
                            }
                            StyledText {
                                Layout.fillWidth:true
                                text: Math.floor(current.temperature_2m)+"°"
                                font.pixelSize:48
                        
                                font.weight:600
                            }
                            StyledText {
                                font.pixelSize: 20
                           
                                Layout.fillWidth:true
                                color:Theme.colorFGDim
                                text: "Feels "+Math.floor(current.apparent_temperature)+"°"
                            }
                        }
                    }
                    
                }
                Loader {
                    active:current!==undefined
                    sourceComponent:current!==undefined?currentWeather:undefined
                    
                    
                }
                Component {
                    id:hourlyWeather

                    ListView {
                       
                        id:hourlyList
                        height:400
                        clip:true
                        width:weatherContent.width
                        focus:true
                        spacing:16
                        boundsBehavior:Flickable.StopAtBounds
                        ScrollBar.vertical: ScrollBar { }
                        model: weatherWindow.hourly
                        delegate:ColumnLayout {
                            required property var modelData
                            required property int index
                            width:weatherContent.width
                            spacing:0;
                            Rectangle {
                                color:"transparent"
                                height:16
                                visible:index === 0
                            }
                            RowLayout {
                                Layout.leftMargin:20
                                Layout.rightMargin:20
                                spacing:20
                                Layout.fillWidth:true
                                Rectangle {
                                    width:40
                                    height:50
                                    color:"transparent"
                                    StyledText {
                                        text: modelData.time
                                        anchors {
                                            horizontalCenter:parent.horizontalCenter
                                            top:parent.top
                                            
                                        }
                                        font.pixelSize:14
                                        color:Theme.colorFGDim
                                    }  
                                    SVGIcon{
                                        anchors {
                                            horizontalCenter:parent.horizontalCenter
                                            bottom:parent.bottom
                                        }
                                        iconName:WeatherUtil.symbolFetch(modelData.weather_code,modelData.is_day)
                                        size:32
                                    }

                                }
                               
                                ColumnLayout {
                                    Layout.fillWidth:true
                                    spacing: -4;
                                    StyledText {
                                        Layout.fillWidth:true
                                        font.pixelSize:24
                                        font.weight:600
                                        text:Math.floor(modelData.temperature_2m)+"°"
                                    }
                                    StyledText {
                                        Layout.fillWidth:true
                                        font.pixelSize:16
                                        color:Theme.colorFGDim
                                        text:"Feels "+Math.floor(modelData.apparent_temperature)+"°"
                                    }
                                }
                                ColumnLayout {
                                    SVGIcon {
                                        iconName:"umbrella"
                                        size:30
                                        iconColor: {
                                            const p =modelData.precipitation_probability
                                            if(p < 25) {
                                                return Theme.colorGreen
                                            }
                                            if(p < 51) {
                                                return Theme.colorYellow
                                            }
                                            return Theme.colorRed
                                        }
                                    }
                                    StyledText {
                                        font.pixelSize:16
                                        text:modelData.precipitation_probability+"%"
                                        Layout.alignment: Qt.AlignHCenter
                                        color: {
                                            const p =modelData.precipitation_probability
                                            if(p < 25) {
                                                return Theme.colorGreen
                                            }
                                            if(p < 51) {
                                                return Theme.colorYellow
                                            }
                                            return Theme.colorRed
                                        }
                                    }
                                }
                            }
                           
                        }
                    }
                    
                    
                }
                Loader {
                    sourceComponent:weatherWindow.hourly!==undefined?hourlyWeather:undefined
                }
                Rectangle {
                    height:20
                    color:"transparent"
                }
            }
        }
    }
}