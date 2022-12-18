import sys

from PyQt5.QtCore import pyqtProperty, QPoint, Qt, QRect, QCoreApplication
from PyQt5.QtGui import QPixmap, QMouseEvent, QWheelEvent
from PyQt5.QtQuick import QQuickPaintedItem, QQuickItem

from QCustomPlot_PyQt5 import *


class CustomPlot(QQuickPaintedItem):

    def __init__(self, parent=None):
        super().__init__(parent)

        self.setFlag(QQuickItem.Flag.ItemHasContents, True)
        self.setAcceptedMouseButtons(Qt.MouseButton.AllButtons)

        self.customPlot = QCustomPlot()

        self.widthChanged.connect(self.updatePlotSize)
        self.heightChanged.connect(self.updatePlotSize)

    def paint(self, painter):
        picture = QPixmap(int(self.width()), int(self.height()))
        qcpPainter = QCPPainter(picture)
        self.customPlot.toPainter(qcpPainter)
        painter.drawPixmap(QPoint(), picture)
        qcpPainter.end()

    def updatePlotSize(self):
        self.customPlot.setGeometry(0, 0, int(self.width()), int(self.height()))
        self.customPlot.setViewport(QRect(0, 0, int(self.width()), int(self.height())))

    def mouseDoubleClickEvent(self, event):
        e = QMouseEvent(event)
        QCoreApplication.postEvent(self.customPlot, e)

    def mouseMoveEvent(self, event):
        e = QMouseEvent(event)
        QCoreApplication.postEvent(self.customPlot, e)

    def mousePressEvent(self, event):
        e = QMouseEvent(event)
        QCoreApplication.postEvent(self.customPlot, e)

    def mouseReleaseEvent(self, event):
        e = QMouseEvent(event)
        QCoreApplication.postEvent(self.customPlot, e)

    def wheelEvent(self, event):
        e = QWheelEvent(event)
        QCoreApplication.postEvent(self.customPlot, e)
        
    # Define the getter of the 'name' property.  The C++ type of the
    # property is QString which Python will convert to and from a string.
    @pyqtProperty('QString')
    def name(self):
        return self._name

    # Define the setter of the 'name' property.
    @name.setter
    def name(self, name):
        self._name = name

    # Define the getter of the 'shoeSize' property.  The C++ type and
    # Python type of the property is int.
    @pyqtProperty(int)
    def shoeSize(self):
        return self._shoeSize

    # Define the setter of the 'shoeSize' property.
    @shoeSize.setter
    def shoeSize(self, shoeSize):
        self._shoeSize = shoeSize
