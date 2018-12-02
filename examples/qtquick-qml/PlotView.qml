import QtQuick 2.0
import QCustomPlot 2.0

Item {
    id: plotForm

    Text {
        id: text
        text: qsTr("Plot View")
    }

    CustomPlot {
        id: customPlot
        anchors.fill: parent

        // Component.onCompleted: initCustomPlot()
    }
}