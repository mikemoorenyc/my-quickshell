import QtQuick // for Text
import QtQuick.Controls
import qs.util
Tooltip {
    id:styledTooltip
    text:"Test text"
    contentItem: Text {
        text:styledTooltip.text
    }
    background: Rectangle {}

}
