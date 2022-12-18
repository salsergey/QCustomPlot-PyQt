#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.1.1
#
# Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http://www.qcustomplot.com

import math

from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPen, QBrush, QColor
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi

from QCustomPlot_PyQt5 import QCP

class MainWindow(QMainWindow):
    def __init__(self, argv, parent=None):
        super().__init__(parent)
        loadUi("mainwindow.ui", self)

        self.setupPlot()

        # configure scroll bars:
        # Since scroll bars only support integer values, we'll set a high default range of -500..500 and
        # divide scroll bar position values by 100 to provide a scroll range -5..5 in floating point
        # axis coordinates. if you want to dynamically grow the range accessible with the scroll bar,
        # just increase the the minimum/maximum values of the scroll bars as needed.
        self.horizontalScrollBar.setRange(-500, 500)
        self.verticalScrollBar.setRange(-500, 500)

        # create connection between axes and scroll bars:
        self.horizontalScrollBar.valueChanged.connect(self.horzScrollBarChanged)
        self.verticalScrollBar.valueChanged.connect(self.vertScrollBarChanged)
        self.plot.xAxis.rangeChanged.connect(self.xAxisChanged)
        self.plot.yAxis.rangeChanged.connect(self.yAxisChanged)

        # initialize axis range (and scroll bar positions via signals we just connected):
        self.plot.xAxis.setRange(0, 6, Qt.AlignmentFlag.AlignCenter)
        self.plot.yAxis.setRange(0, 10, Qt.AlignmentFlag.AlignCenter)
    
    def setupPlot(self):
        # The following plot setup is mostly taken from the plot demos:
        self.plot.addGraph()
        self.plot.graph().setPen(QPen(Qt.GlobalColor.blue))
        self.plot.graph().setBrush(QBrush(QColor(0, 0, 255, 20)))
        self.plot.addGraph()
        self.plot.graph().setPen(QPen(Qt.GlobalColor.red))
        x, y0, y1 = [], [], []
        for i in range(500):
            x.append((i/499.0-0.5)*10)
            y0.append(math.exp(-x[i]*x[i]*0.25)*math.sin(x[i]*5)*5)
            y1.append(math.exp(-x[i]*x[i]*0.25)*5)
        self.plot.graph(0).setData(x, y0)
        self.plot.graph(1).setData(x, y1)
        self.plot.axisRect().setupFullAxesBox(True)
        self.plot.setInteractions(QCP.Interaction.iRangeDrag | QCP.Interaction.iRangeZoom)

    def horzScrollBarChanged(self, value):
        if math.fabs(self.plot.xAxis.range().center()-value/100.0) > 0.01: # if user is dragging plot, we don't want to replot twice
            self.plot.xAxis.setRange(value/100.0, self.plot.xAxis.range().size(), Qt.AlignmentFlag.AlignCenter)
            self.plot.replot()

    def vertScrollBarChanged(self, value):
        if math.fabs(self.plot.yAxis.range().center()+value/100.0) > 0.01: # if user is dragging plot, we don't want to replot twice
            self.plot.yAxis.setRange(-value/100.0, self.plot.yAxis.range().size(), Qt.AlignmentFlag.AlignCenter)
            self.plot.replot()

    def xAxisChanged(self, range):
        self.horizontalScrollBar.setValue(round(range.center()*100.0)) # adjust position of scroll bar slider
        self.horizontalScrollBar.setPageStep(round(range.size()*100.0)) # adjust size of scroll bar slider

    def yAxisChanged(self, range):
        self.verticalScrollBar.setValue(round(-range.center()*100.0)) # adjust position of scroll bar slider
        self.verticalScrollBar.setPageStep(round(range.size()*100.0)) # adjust size of scroll bar slider
