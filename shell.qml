//@ pragma IconTheme Papirus-Dark

import Quickshell // for PanelWindow
import QtQuick // for Text
import "Bar"
import qs.Bar.Tray
import qs.util
import qs.OSD
import qs.Bar.QuickSettings
ShellRoot {
  
  Bar{}
  TrayWindow{}
  ClickMask{}
  Osd{}
  QuickSettingsWindow{}
  
}