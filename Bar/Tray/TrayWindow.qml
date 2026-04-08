pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.util

PanelContainer {
    id:baseContainer
    
   
    property bool menuOpen: false

    
  anchors {
        right: true
      bottom: true
    }
    visible:ShellContext.openWindow == "SYSTEM_TRAY"
    implicitHeight:iconsContainer.implicitHeight + (Theme.marginButton * 2) + 4
    implicitWidth:iconsContainer.implicitWidth + (Theme.marginButton * 2) + 4
   

    margins {
        right:ShellContext.trayButton?Quickshell.screens[0].width - (ShellContext.trayButton.x + ShellContext.trayButton.implicitWidth):0
        bottom:0
    }
  
        
        
        RowLayout {
            id:iconsContainer
            anchors.centerIn:parent
            spacing:Theme.marginButton * 2;
              Repeater {
    model: SystemTray.items

    delegate: IconImage {
      id: iconImage

      required property SystemTrayItem modelData

      source: modelData ? modelData.icon : ""
      implicitSize: 16

      QsMenuOpener {
        id: trayMenuOpener
        menu: iconImage.modelData ? iconImage.modelData.menu : null
      }

      ContextMenu.menu: TrayMenu { model: trayMenuOpener.children }

      MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        anchors.fill: parent
        id:mouseContainer
        hoverEnabled:true
        onClicked: mouse => {
          if (mouse.button === Qt.LeftButton)
            iconImage.modelData.activate();
          else if (mouse.button === Qt.MiddleButton)
            iconImage.modelData.secondaryActivate();
        }
      }

    }
  }

  component TrayMenu: Menu {
    id: trayMenu

    property alias model: iconImageMenuInstantiator.model

    popupType: Popup.Window

    Instantiator {
      id: iconImageMenuInstantiator

      onObjectAdded: (index, object) => {
        if (object instanceof Menu)
          trayMenu.insertMenu(index, object);
        else
          trayMenu.insertItem(index, object);
      }

      onObjectRemoved: (index, object) => {
        if (object instanceof Menu)
          trayMenu.removeMenu(object);
        else
          trayMenu.removeItem(object);
      }

      delegate: DelegateChooser {
        role: "isSeparator"

        DelegateChoice {
          roleValue: false

          delegate: DelegateChooser {
            role: "hasChildren"

            DelegateChoice {
              roleValue: false

              delegate: MenuItem {
                id: menuItem

                required property QsMenuEntry modelData

                icon.source: modelData ? modelData.icon : ""
                text: modelData ? modelData.text : ""

                enabled: modelData ? modelData.enabled : false
                checkable: modelData ? modelData.buttonType !== QsMenuButtonType.None : false

                indicator: Loader {
                  x: menuItem.mirrored ? menuItem.width - width - menuItem.rightPadding : menuItem.leftPadding
                  y: menuItem.topPadding + (menuItem.availableHeight - height) / 2

                  sourceComponent: {
                    if (!menuItem.modelData) return null;
                    if (menuItem.modelData.buttonType === QsMenuButtonType.CheckBox)
                      return checkBoxComponent;
                    else if (menuItem.modelData.buttonType === QsMenuButtonType.RadioButton)
                      return radioButtonComponent;
                    else
                      return null;
                  }
                }

                onTriggered: modelData.triggered()

                Component {
                  id: checkBoxComponent
                  CheckBox { checkState: menuItem.modelData ? menuItem.modelData.checkState : Qt.Unchecked }
                }

                Component {
                  id: radioButtonComponent
                  RadioButton { checked: menuItem.modelData ? menuItem.modelData.checkState === Qt.Checked : false }
                }
              }
            }

            DelegateChoice {
              roleValue: true

              delegate: trayMenuComponent
            }
          }
        }

        DelegateChoice {
          roleValue: true

          delegate: MenuSeparator {}
        }
      }
    }
  }

  Component {
    id: trayMenuComponent

    TrayMenu {
      id: trayMenu

      required property QsMenuEntry modelData

      model: menuEntryOpener.children

      enabled: modelData ? modelData.enabled : false
      title: modelData ? modelData.text : ""

      QsMenuOpener {
        id: menuEntryOpener
        menu: trayMenu.modelData ? trayMenu.modelData : null
      }
    }
  }
        }
    
   
  

  
}