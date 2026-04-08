//@ pragma IconTheme Papirus-Dark

import Quickshell // for PanelWindow
import QtQuick // for Text
import "Bar"
import qs.Bar.Tray
import qs.util
import qs.OSD
import qs.Bar.QuickSettings
import qs.Bar.CalendarWindow
ShellRoot {

  Bar{}
  TrayWindow{}
 
  Osd{}
  QuickSettingsWindow{}
  CalendarWindow{}
     ClickMask{}
}