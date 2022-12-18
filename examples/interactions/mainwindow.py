#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.1.1
#
# Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http:#www.qcustomplot.com

import math, random

from PyQt5.QtCore import Qt, QPointF
from PyQt5.QtGui import QPen, QColor, QFont
from PyQt5.QtWidgets import QMainWindow, QLineEdit, QMenu, QInputDialog
from PyQt5.uic import loadUi

from QCustomPlot_PyQt5 import *


class MainWindow(QMainWindow):

    def __init__(self, argv, parent=None):
        super().__init__(parent)
        loadUi("mainwindow.ui", self)
        
        self.customPlot.setInteractions(QCP.Interaction.iRangeDrag | QCP.Interaction.iRangeZoom | QCP.Interaction.iSelectAxes |
                                        QCP.Interaction.iSelectLegend | QCP.Interaction.iSelectPlottables)
        self.customPlot.xAxis.setRange(-8, 8)
        self.customPlot.yAxis.setRange(-5, 5)
        self.customPlot.axisRect().setupFullAxesBox()
        
        self.customPlot.plotLayout().insertRow(0)
        self.title = QCPTextElement(self.customPlot, "Interaction Example", QFont("sans", 17, QFont.Weight.Bold))
        self.customPlot.plotLayout().addElement(0, 0, self.title)
        
        self.customPlot.xAxis.setLabel("x Axis")
        self.customPlot.yAxis.setLabel("y Axis")
        self.customPlot.legend.setVisible(True)
        legendFont = QFont()
        legendFont.setPointSize(10)
        self.customPlot.legend.setFont(legendFont)
        self.customPlot.legend.setSelectedFont(legendFont)
        self.customPlot.legend.setSelectableParts(QCPLegend.SelectablePart.spItems)  # legend box shall not be selectable, only legend items
        
        self.addRandomGraph()
        self.addRandomGraph()
        self.addRandomGraph()
        self.addRandomGraph()
        self.customPlot.rescaleAxes()
        
        # connect slot that ties some axis selections together (especially opposite axes):
        self.customPlot.selectionChangedByUser.connect(self.selectionChanged)
        # connect slots that takes care that when an axis is selected, only that direction can be dragged and zoomed:
        self.customPlot.mousePress.connect(self.mousePress)
        self.customPlot.mouseWheel.connect(self.mouseWheel)
        
        # make bottom and left axes transfer their ranges to top and right axes:
        self.customPlot.xAxis.rangeChanged.connect(self.customPlot.xAxis2.setRange)
        self.customPlot.yAxis.rangeChanged.connect(self.customPlot.yAxis2.setRange)
        
        # connect some interaction slots:
        self.customPlot.axisDoubleClick.connect(self.axisLabelDoubleClick)
        self.customPlot.legendDoubleClick.connect(self.legendDoubleClick)
        self.title.doubleClicked.connect(self.titleDoubleClick)
        
        # connect slot that shows a message in the status bar when a graph is clicked:
        self.customPlot.plottableClick.connect(self.graphClicked)
        
        # setup policy and connect slot for context menu popup:
        self.customPlot.setContextMenuPolicy(Qt.ContextMenuPolicy.CustomContextMenu)
        self.customPlot.customContextMenuRequested.connect(self.contextMenuRequest)

    def titleDoubleClick(self, event):
        title = self.sender()
        if not title is None:
            # Set the plot title by double clicking on it
            newTitle, ok = QInputDialog.getText(self, "QCustomPlot example", "New plot title:", QLineEdit.EchoMode.Normal, title.text())
            if ok:
                title.setText(newTitle)
                self.customPlot.replot()

    def axisLabelDoubleClick(self, axis, part):
        # Set an axis label by double clicking on it
        if part == QCPAxis.SelectablePart.spAxisLabel:  # only react when the actual axis label is clicked, not tick label or axis backbone
            newLabel, ok = QInputDialog.getText(self, "QCustomPlot example", "New axis label:", QLineEdit.EchoMode.Normal, axis.label())
            if ok:
                axis.setLabel(newLabel)
                self.customPlot.replot()

    def legendDoubleClick(self, legend, item):
        # Rename a graph by double clicking on its legend item
        if item is not None:  # only react if item was clicked (user could have clicked on border padding of legend where there is no item, then item is 0)
            newName, ok = QInputDialog.getText(self, "QCustomPlot example", "New graph name:", QLineEdit.EchoMode.Normal, item.plottable().name())
            if ok:
                item.plottable().setName(newName)
                self.customPlot.replot()

    def selectionChanged(self):
        # normally, axis base line, axis tick labels and axis labels are selectable separately, but we want
        # the user only to be able to select the axis as a whole, so we tie the selected states of the tick labels
        # and the axis base line together. However, the axis label shall be selectable individually.
        #
        # The selection state of the left and right axes shall be synchronized as well as the state of the
        # bottom and top axes.
        #
        # Further, we want to synchronize the selection of the graphs with the selection state of the respective
        # legend item belonging to that graph. So the user can select a graph by either clicking on the graph itself
        # or on its legend item.
    
        # make top and bottom axes be selected synchronously, and handle axis and tick labels as one selectable object:
        if (self.customPlot.xAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone or
            self.customPlot.xAxis.selectedParts() & QCPAxis.SelectablePart.spTickLabels != QCPAxis.SelectablePart.spNone or
            self.customPlot.xAxis2.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone or
            self.customPlot.xAxis2.selectedParts() & QCPAxis.SelectablePart.spTickLabels != QCPAxis.SelectablePart.spNone):
            self.customPlot.xAxis2.setSelectedParts(QCPAxis.SelectablePart.spAxis | QCPAxis.SelectablePart.spTickLabels)
            self.customPlot.xAxis.setSelectedParts(QCPAxis.SelectablePart.spAxis | QCPAxis.SelectablePart.spTickLabels)
        # make left and right axes be selected synchronously, and handle axis and tick labels as one selectable object:
        if (self.customPlot.yAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone or
            self.customPlot.yAxis.selectedParts() & QCPAxis.SelectablePart.spTickLabels != QCPAxis.SelectablePart.spNone or
            self.customPlot.yAxis2.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone or
            self.customPlot.yAxis2.selectedParts() & QCPAxis.SelectablePart.spTickLabels != QCPAxis.SelectablePart.spNone):
            self.customPlot.yAxis2.setSelectedParts(QCPAxis.SelectablePart.spAxis | QCPAxis.SelectablePart.spTickLabels)
            self.customPlot.yAxis.setSelectedParts(QCPAxis.SelectablePart.spAxis | QCPAxis.SelectablePart.spTickLabels)
        
        # synchronize selection of graphs with selection of corresponding legend items:
        for i in range(self.customPlot.graphCount()):
            graph = self.customPlot.graph(i)
            item = self.customPlot.legend.itemWithPlottable(graph)
            if item.selected() or graph.selected():
                item.setSelected(True)
                graph.setSelection(QCPDataSelection(graph.data().dataRange()))

    def mousePress(self):
        # if an axis is selected, only allow the direction of that axis to be dragged
        # if no axis is selected, both directions may be dragged
        
        if self.customPlot.xAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone:
            self.customPlot.axisRect().setRangeDrag(self.customPlot.xAxis.orientation())
        elif self.customPlot.yAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone:
            self.customPlot.axisRect().setRangeDrag(self.customPlot.yAxis.orientation())
        else:
            self.customPlot.axisRect().setRangeDrag(Qt.Orientation.Horizontal | Qt.Orientation.Vertical)

    def mouseWheel(self):
        # if an axis is selected, only allow the direction of that axis to be zoomed
        # if no axis is selected, both directions may be zoomed

        if self.customPlot.xAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone:
            self.customPlot.axisRect().setRangeZoom(self.customPlot.xAxis.orientation())
        elif self.customPlot.yAxis.selectedParts() & QCPAxis.SelectablePart.spAxis != QCPAxis.SelectablePart.spNone:
            self.customPlot.axisRect().setRangeZoom(self.customPlot.yAxis.orientation())
        else:
            self.customPlot.axisRect().setRangeZoom(Qt.Orientation.Horizontal | Qt.Orientation.Vertical)

    def addRandomGraph(self):
        n = 50  # number of points in graph
        xScale = (random.random() + 0.5)*2
        yScale = (random.random() + 0.5)*2
        xOffset = (random.random() - 0.5)*4
        yOffset = (random.random() - 0.5)*10
        r1 = (random.random() - 0.5)*2
        r2 = (random.random() - 0.5)*2
        r3 = (random.random() - 0.5)*2
        r4 = (random.random() - 0.5)*2
        x, y = [], []
        for i in range(n):
            x.append((i/float(n)-0.5)*10.0*xScale + xOffset)
            y.append((math.sin(x[i]*r1*5)*math.sin(math.cos(x[i]*r2)*r4*3)+r3*math.cos(math.sin(x[i])*r4*2))*yScale + yOffset)
        
        self.customPlot.addGraph()
        self.customPlot.graph().setName("New graph {}".format(self.customPlot.graphCount()-1))
        self.customPlot.graph().setData(x, y)
        self.customPlot.graph().setLineStyle(QCPGraph.LineStyle(random.randint(1, 6)))
        if random.randint(0, 100) > 50:
            self.customPlot.graph().setScatterStyle(QCPScatterStyle(QCPScatterStyle.ScatterShape(random.randint(1, 15))))
        graphPen = QPen()
        graphPen.setColor(QColor(random.randint(10, 255), random.randint(10, 255), random.randint(10, 255)))
        graphPen.setWidthF(random.random()*2+1)
        self.customPlot.graph().setPen(graphPen)
        self.customPlot.replot()

    def removeSelectedGraph(self):
        if len(self.customPlot.selectedGraphs()) > 0:
            self.customPlot.removeGraph(self.customPlot.selectedGraphs()[0])
            self.customPlot.replot()

    def removeAllGraphs(self):
        self.customPlot.clearGraphs()
        self.customPlot.replot()

    def contextMenuRequest(self, pos):
        menu = QMenu(self)
        menu.setAttribute(Qt.WidgetAttribute.WA_DeleteOnClose)
        
        if self.customPlot.legend.selectTest(QPointF(pos), False) >= 0:  # context menu on legend requested
            menu.addAction("Move to top left", self.moveLegend).setData(int(Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignLeft))
            menu.addAction("Move to top center", self.moveLegend).setData(int(Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignHCenter))
            menu.addAction("Move to top right", self.moveLegend).setData(int(Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignRight))
            menu.addAction("Move to bottom right", self.moveLegend).setData(int(Qt.AlignmentFlag.AlignBottom | Qt.AlignmentFlag.AlignRight))
            menu.addAction("Move to bottom left", self.moveLegend).setData(int(Qt.AlignmentFlag.AlignBottom | Qt.AlignmentFlag.AlignLeft))
        else:  # general context menu on graphs requested
            menu.addAction("Add random graph", self.addRandomGraph)
            if len(self.customPlot.selectedGraphs()) > 0:
                menu.addAction("Remove selected graph", self.removeSelectedGraph)
            if self.customPlot.graphCount() > 0:
                menu.addAction("Remove all graphs", self.removeAllGraphs)
        
        menu.popup(self.customPlot.mapToGlobal(pos))

    def moveLegend(self):
        self.customPlot.axisRect().insetLayout().setInsetAlignment(0, Qt.AlignmentFlag(self.sender().data()))
        self.customPlot.replot()

    def graphClicked(self, plottable, dataIndex):
        # since we know we only have QCPGraphs in the plot, we can immediately access interface1D()
        # usually it's better to first check whether interface1D() returns non-zero, and only then use it.
        dataValue = plottable.interface1D().dataMainValue(dataIndex)
        message = "Clicked on graph '{}' at data point #{} with value {}.".format(plottable.name(), dataIndex, dataValue)
        self.statusBar.showMessage(message, 2500)
