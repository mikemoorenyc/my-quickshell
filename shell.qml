//@ pragma IconTheme Tela-dark

import Quickshell // for PanelWindow
import QtQuick // for Text
import "Bar"
import qs.Bar.Tray
import qs.util
import qs.OSD
import qs.Bar.QuickSettings
import qs.Bar.CalendarWindow
import qs.Notifications
import qs.Bar.Apps
import qs.Tooltip
import qs.Launcher
ShellRoot {
    
  NotificationWindow{}
  PreviewWindow{}
  Bar{}
  TrayWindow{}
 
  Osd{}
  QuickSettingsWindow{}
  CalendarWindow{}

  LauncherWindow{}
  ToolTipWindow{}
  ClickMask{}
}