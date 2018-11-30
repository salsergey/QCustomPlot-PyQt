#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.0.0
#
# Authors: Dmitry Voronin, Giuseppe Corbelli
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http:#www.qcustomplot.com

import math, random

from PyQt5.QtCore import QTime, QTimer, QPointF, Qt, QLocale, QDateTime, QMargins
from PyQt5.QtGui import QPen, QBrush, QColor, QRadialGradient, QFont, QPainterPath, QLinearGradient, QPixmap
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi

import QCustomPlot2

from QCustomPlot2 import (QCP, QCPAxisTickerTime, QCPColorMap, QCPRange, QCPColorScale, QCPAxis, QCPColorGradient,
    QCPMarginGroup, QCPScatterStyle, QCPGraph, QCustomPlot, QCPLineEnding, QCPBars, QCPErrorBars, QCPAxisTickerDateTime,
    QCPAxisTickerText, QCPGraphData, QCPAxisTickerPi, QCPTextElement, QCPItemBracket, QCPItemText, QCPItemTracer,
    QCPItemPosition, QCPItemCurve)

class MainWindow(QMainWindow):
    def __init__(self, argv, parent=None):
        super().__init__(parent)
        loadUi("examples/plots/mainwindow.ui", self)

        self._available_demos = {
            0: self.setupQuadraticDemo,
            1: self.setupSimpleDemo,
            2: self.setupSincScatterDemo,
            3: self.setupScatterStyleDemo,
            4: self.setupScatterPixmapDemo,
            5: self.setupLineStyleDemo,
            6: self.setupDateDemo,
            7: self.setupTextureBrushDemo,
            8: self.setupMultiAxisDemo,
            9: self.setupLogarithmicDemo,
            10: self.setupRealtimeDataDemo,
            11: self.setupParametricCurveDemo,
            12: self.setupBarChartDemo,
            13: self.setupStatisticalDemo,
            14: self.setupSimpleItemDemo,
            15: self.setupItemDemo,
            16: self.setupStyledDemo,
            17: self.setupAdvancedAxesDemo,
            18: self.setupColorMapDemo,
            19: self.setupFinancialDemo,
        }

        self.currentDemoIndex = -1
        self.demoName = ""
        self.setGeometry(400, 250, 542, 390)
        try:
            demoIndex = int(argv[-1])
            self._available_demos[demoIndex]
        except Exception:
            demoIndex = 0

        self.setupDemo(demoIndex)

    def setupDemo(self, demoIndex):
        self._available_demos[demoIndex]()
        self.setWindowTitle("QCustomPlot demo: {}".format(self.demoName))
        self.statusBar.clearMessage()
        self.currentDemoIndex = demoIndex
        self.customPlot.replot()

    def setupQuadraticDemo(self):
        self.demoName = "Quadratic Demo"
        # generate some data: initialize with entries 0..100
        x = [0] * 100
        y = [0] * 100
        for i in range(0, 100):
            x[i] = i/50.0 - 1  # x goes from -1 to 1
            y[i] = x[i]*x[i]  # let's plot a quadratic function

        # create graph and assign data to it:
        self.customPlot.addGraph()
        self.customPlot.graph(0).setData(x, y)
        # give the axes some labels:
        self.customPlot.xAxis.setLabel("x")
        self.customPlot.yAxis.setLabel("y")
        # set axes ranges, so we see all data:
        self.customPlot.xAxis.setRange(-1, 1)
        self.customPlot.yAxis.setRange(0, 1)

    def setupSimpleDemo(self):
        self.demoName = "Simple Demo"
        # add two new graphs and set their look:
        self.customPlot.addGraph()
        self.customPlot.graph(0).setPen(QPen(Qt.blue)) # line color blue for first graph
        self.customPlot.graph(0).setBrush(QBrush(QColor(0, 0, 255, 20))) # first graph will be filled with translucent blue
        self.customPlot.addGraph()
        self.customPlot.graph(1).setPen(QPen(Qt.red)) # line color red for second graph
        # generate some points of data (y0 for first, y1 for second graph):
        x, y0, y1 = [], [], []
        for i in range (251):
            x.append(i)
            y0.append(math.exp(-i/150.0)*math.cos(i/10.0)) # exponentially decaying cosine
            y1.append(math.exp(-i/150.0))             # exponential envelope
        # configure right and top axis to show ticks but no labels:
        # (see QCPAxisRect.setupFullAxesBox for a quicker method to do this)
        self.customPlot.xAxis2.setVisible(True)
        self.customPlot.xAxis2.setTickLabels(False)
        self.customPlot.yAxis2.setVisible(True)
        self.customPlot.yAxis2.setTickLabels(False)
        # make left and bottom axes always transfer their ranges to right and top axes:
        self.customPlot.xAxis.rangeChanged.connect(self.customPlot.xAxis2.setRange)
        self.customPlot.yAxis.rangeChanged.connect(self.customPlot.yAxis2.setRange)
        # pass data points to graphs:
        self.customPlot.graph(0).setData(x, y0)
        self.customPlot.graph(1).setData(x, y1)
        # let the ranges scale themselves so graph 0 fits perfectly in the visible area:
        self.customPlot.graph(0).rescaleAxes()
        # same thing for graph 1, but only enlarge ranges (in case graph 1 is smaller than graph 0):
        self.customPlot.graph(1).rescaleAxes(True)
        # Note: we could have also just called self.customPlot.rescaleAxes() instead
        # Allow user to drag axis ranges with mouse, zoom with mouse wheel and select graphs by clicking:
        self.customPlot.setInteractions(QCP.iRangeDrag or QCP.iRangeZoom or QCP.iSelectPlottables)

    def setupSincScatterDemo(self):
        self.demoName = "Sinc Scatter Demo"
        self.customPlot.legend.setVisible(True)
        self.customPlot.legend.setFont(QFont("Helvetica",9))
        # set locale to english, so we get english decimal separator:
        self.customPlot.setLocale(QLocale(QLocale.English, QLocale.UnitedKingdom))
        # add confidence band graphs:
        self.customPlot.addGraph()
        pen = QPen()
        pen.setStyle(Qt.DotLine)
        pen.setWidth(1)
        pen.setColor(QColor(180,180,180))
        self.customPlot.graph(0).setName("Confidence Band 68%")
        self.customPlot.graph(0).setPen(pen)
        self.customPlot.graph(0).setBrush(QBrush(QColor(255,50,30,20)))
        self.customPlot.addGraph()
        self.customPlot.legend.removeItem(self.customPlot.legend.itemCount()-1) # don't show two confidence band graphs in legend
        self.customPlot.graph(1).setPen(pen)
        self.customPlot.graph(0).setChannelFillGraph(self.customPlot.graph(1))
        # add theory curve graph:
        self.customPlot.addGraph()
        pen.setStyle(Qt.DashLine)
        pen.setWidth(2)
        pen.setColor(Qt.red)
        self.customPlot.graph(2).setPen(pen)
        self.customPlot.graph(2).setName("Theory Curve")
        # add data point graph:
        self.customPlot.addGraph()
        self.customPlot.graph(3).setPen(QPen(Qt.blue))
        self.customPlot.graph(3).setLineStyle(QCPGraph.lsNone)
        self.customPlot.graph(3).setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssCross, 4))
        # add error bars:
        # TODO
        #errorBars = QCPErrorBars(self.customPlot.xAxis, self.customPlot.yAxis)
        #errorBars.removeFromLegend()
        #errorBars.setAntialiased(False)
        #errorBars.setDataPlottable(self.customPlot.graph(3))
        #errorBars.setPen(QPen(QColor(180,180,180)))
        self.customPlot.graph(3).setName("Measurement")
        
        # generate ideal sinc curve data and some randomly perturbed data for scatter plot:
        x0, y0 = [], []
        yConfUpper, yConfLower = [], []
        for i in range (250):
            x0.append((i/249.0-0.5)*30+0.01) # by adding a small offset we make sure not do divide by zero in next code line
            y0.append(math.sin(x0[i])/x0[i]) # sinc function
            yConfUpper.append(y0[i]+0.15)
            yConfLower.append(y0[i]-0.15)
            x0[i] *= 1000
        x1, y1, y1err = [], [], []
        for i in range (50):
            # generate a gaussian distributed random number:
            tmp1 = random.random()
            tmp2 = random.random()
            r = math.sqrt(-2*math.log(tmp1))*math.cos(2*math.pi*tmp2) # box-muller transform for gaussian distribution
            # set y1 to value of y0 plus a random gaussian pertubation:
            x1.append((i/50.0-0.5)*30+0.25)
            y1.append(math.sin(x1[i])/x1[i]+r*0.15)
            x1[i] *= 1000
            y1err.append(0.15)
        # pass data to graphs and let QCustomPlot determine the axes ranges so the whole thing is visible:
        self.customPlot.graph(0).setData(x0, yConfUpper)
        self.customPlot.graph(1).setData(x0, yConfLower)
        self.customPlot.graph(2).setData(x0, y0)
        self.customPlot.graph(3).setData(x1, y1)
        # TODO
        #errorBars.setData(y1err)
        self.customPlot.graph(2).rescaleAxes()
        self.customPlot.graph(3).rescaleAxes(True)
        # setup look of bottom tick labels:
        self.customPlot.xAxis.setTickLabelRotation(30)
        self.customPlot.xAxis.ticker().setTickCount(9)
        self.customPlot.xAxis.setNumberFormat("ebc")
        self.customPlot.xAxis.setNumberPrecision(1)
        self.customPlot.xAxis.moveRange(-10)
        # make top right axes clones of bottom left axes. Looks prettier:
        self.customPlot.axisRect().setupFullAxesBox()

    def setupScatterStyleDemo(self):
        self.demoName = "Line Style Demo"
        self.customPlot.legend.setVisible(True)
        self.customPlot.legend.setFont(QFont("Helvetica", 9))
        self.customPlot.legend.setRowSpacing(-3)
        shapes = [QCPScatterStyle.ssCross, QCPScatterStyle.ssPlus, QCPScatterStyle.ssCircle, QCPScatterStyle.ssDisc, QCPScatterStyle.ssSquare, QCPScatterStyle.ssDiamond, QCPScatterStyle.ssStar, QCPScatterStyle.ssTriangle, QCPScatterStyle.ssTriangleInverted, QCPScatterStyle.ssCrossSquare, QCPScatterStyle.ssPlusSquare, QCPScatterStyle.ssCrossCircle, QCPScatterStyle.ssPlusCircle, QCPScatterStyle.ssPeace, QCPScatterStyle.ssCustom]
        
        pen = QPen()
        # add graphs with different scatter styles:
        for i, shape in enumerate(shapes):
            self.customPlot.addGraph()
            pen.setColor(QColor(math.sin(i*0.3)*100+100, math.sin(i*0.6+0.7)*100+100, math.sin(i*0.4+0.6)*100+100))
            # generate data:
            x, y = [], []
            for k in range(10):
                x.append(k/10.0 * 4*3.14 + 0.01)
                y.append(7*math.sin(x[k])/x[k] + (len(shapes)-i)*5)
            self.customPlot.graph().setData(x, y)
            self.customPlot.graph().rescaleAxes(True)
            self.customPlot.graph().setPen(pen)
            self.customPlot.graph().setName(str(shape))
            self.customPlot.graph().setLineStyle(QCPGraph.lsLine)
            # set scatter style:
            if shape != QCPScatterStyle.ssCustom:
                self.customPlot.graph().setScatterStyle(QCPScatterStyle(shape, 10))
            else:
                customScatterPath = QPainterPath()
                for i in range(3):
                    customScatterPath.cubicTo(math.cos(2*math.pi*i/3.0)*9, math.sin(2*math.pi*i/3.0)*9, math.cos(2*math.pi*(i+0.9)/3.0)*9, math.sin(2*math.pi*(i+0.9)/3.0)*9, 0, 0)
                self.customPlot.graph().setScatterStyle(QCPScatterStyle(customScatterPath, QPen(Qt.black, 0), QColor(40, 70, 255, 50), 10))
        # set blank axis lines:
        self.customPlot.rescaleAxes()
        self.customPlot.xAxis.setTicks(False)
        self.customPlot.yAxis.setTicks(False)
        self.customPlot.xAxis.setTickLabels(False)
        self.customPlot.yAxis.setTickLabels(False)
        # make top right axes clones of bottom left axes:
        self.customPlot.axisRect().setupFullAxesBox()

    def setupLineStyleDemo(self):
        self.demoName = "Line Style Demo"
        self.customPlot.legend.setVisible(True)
        self.customPlot.legend.setFont(QFont("Helvetica", 9))
        pen = QPen()
        lineNames = ["lsNone", "lsLine", "lsStepLeft", "lsStepRight", "lsStepCenter", "lsImpulse"]
        # add graphs with different line styles:
        for i in range(int(QCPGraph.lsImpulse)):
            self.customPlot.addGraph()
            pen.setColor(QColor(math.sin(i*1+1.2)*80+80, math.sin(i*0.3+0)*80+80, math.sin(i*0.3+1.5)*80+80))
            self.customPlot.graph().setPen(pen)
            self.customPlot.graph().setName(lineNames[i-int(QCPGraph.lsNone)])
            self.customPlot.graph().setLineStyle(QCPGraph.LineStyle(i))
            self.customPlot.graph().setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssCircle, 5))
            # generate data:
            x, y = [], []
            for j in range(15):
                x.append(j/15.0 * 5*3.14 + 0.01)
                y.append(7*math.sin(x[j])/x[j] - (i-QCPGraph.lsNone)*5 + (QCPGraph.lsImpulse)*5 + 2)
            self.customPlot.graph().setData(x, y)
            self.customPlot.graph().rescaleAxes(True)
        # zoom out a bit:
        self.customPlot.yAxis.scaleRange(1.1, self.customPlot.yAxis.range().center())
        self.customPlot.xAxis.scaleRange(1.1, self.customPlot.xAxis.range().center())
        # set blank axis lines:
        self.customPlot.xAxis.setTicks(False)
        self.customPlot.yAxis.setTicks(True)
        self.customPlot.xAxis.setTickLabels(False)
        self.customPlot.yAxis.setTickLabels(True)
        # make top right axes clones of bottom left axes:
        self.customPlot.axisRect().setupFullAxesBox()

    def setupScatterPixmapDemo(self):
        self.demoName = "Scatter Pixmap Demo"

    def setupDateDemo(self):
        self.demoName = "Date Demo"
        # set locale to english, so we get english month names:
        self.customPlot.setLocale(QLocale(QLocale.English, QLocale.UnitedKingdom))
        # seconds of current time, we'll use it as starting point in time for data:
        now = QDateTime.currentDateTime().toTime_t()
        random.seed(8) # set the random seed, so we always get the same random data
        # create multiple graphs:
        for gi in range(5):
            self.customPlot.addGraph()
            color = QColor(20+200/4.0*gi,70*(1.6-gi/4.0), 150, 150)
            self.customPlot.graph().setLineStyle(QCPGraph.lsLine)
            self.customPlot.graph().setPen(QPen(color.lighter(200)))
            self.customPlot.graph().setBrush(QBrush(color))
            # generate random walk data:
            timeData = []
            for i in range(250):
                key = now + 24*3600*i
                if i == 0:
                    value = (i/50.0+1)*(random.random()-0.5)
                else:
                    value = math.fabs(timeData[i-1].value)*(1+0.02/4.0*(4-gi)) + (i/50.0+1)*(random.random()-0.5)
                timeData.append(QCPGraphData(key, value))
            self.customPlot.graph().data().set(timeData)
        # configure bottom axis to show date instead of number:
        dateTicker = QCPAxisTickerDateTime()
        dateTicker.setDateTimeFormat("d. MMMM\nyyyy")
        self.customPlot.xAxis.setTicker(dateTicker)
        # configure left axis text labels:
        textTicker = QCPAxisTickerText()
        textTicker.addTick(10, "a bit\nlow")
        textTicker.addTick(50, "quite\nhigh")
        self.customPlot.yAxis.setTicker(textTicker)
        # set a more compact font size for bottom and left axis tick labels:
        self.customPlot.xAxis.setTickLabelFont(QFont(QFont().family(), 8))
        self.customPlot.yAxis.setTickLabelFont(QFont(QFont().family(), 8))
        # set axis labels:
        self.customPlot.xAxis.setLabel("Date")
        self.customPlot.yAxis.setLabel("Random wobbly lines value")
        # make top and right axes visible but without ticks and labels:
        self.customPlot.xAxis2.setVisible(True)
        self.customPlot.yAxis2.setVisible(True)
        self.customPlot.xAxis2.setTicks(False)
        self.customPlot.yAxis2.setTicks(False)
        self.customPlot.xAxis2.setTickLabels(False)
        self.customPlot.yAxis2.setTickLabels(False)
        # set axis ranges to show all data:
        self.customPlot.xAxis.setRange(now, now+24*3600*249)
        self.customPlot.yAxis.setRange(0, 60)
        # show legend with slightly transparent background brush:
        self.customPlot.legend.setVisible(True)
        self.customPlot.legend.setBrush(QColor(255, 255, 255, 150))

    def setupTextureBrushDemo(self):
        self.demoName = "Texture Brush Demo"

    def setupMultiAxisDemo(self):
        self.customPlot.setInteractions(QCP.iRangeDrag or QCP.iRangeZoom)
        self.demoName = "Multi Axis Demo"

        self.customPlot.setLocale(QLocale(QLocale.English, QLocale.UnitedKingdom)) # period as decimal separator and comma as thousand separator
        self.customPlot.legend.setVisible(True)
        legendFont = QFont()  # start out with MainWindow's font..
        legendFont.setPointSize(9) # and make a bit smaller for legend
        self.customPlot.legend.setFont(legendFont)
        self.customPlot.legend.setBrush(QBrush(QColor(255,255,255,230)))
        # by default, the legend is in the inset layout of the main axis rect. So this is how we access it to change legend placement:
        self.customPlot.axisRect().insetLayout().setInsetAlignment(0, Qt.AlignBottom or Qt.AlignRight)

        # setup for graph 0: key axis left, value axis bottom
        # will contain left maxwell-like function
        self.customPlot.addGraph(self.customPlot.yAxis, self.customPlot.xAxis)
        self.customPlot.graph(0).setPen(QPen(QColor(255, 100, 0)))
        self.customPlot.graph(0).setBrush(QBrush(QPixmap("./balboa.jpg"))) # fill with texture of specified image
        self.customPlot.graph(0).setLineStyle(QCPGraph.lsLine)
        self.customPlot.graph(0).setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssDisc, 5))
        self.customPlot.graph(0).setName("Left maxwell function")

        # setup for graph 1: key axis bottom, value axis left (those are the default axes)
        # will contain bottom maxwell-like function with error bars
        self.customPlot.addGraph()
        self.customPlot.graph(1).setPen(QPen(Qt.red))
        self.customPlot.graph(1).setBrush(QBrush(QPixmap("./balboa.jpg"))) # same fill as we used for graph 0
        self.customPlot.graph(1).setLineStyle(QCPGraph.lsStepCenter)
        self.customPlot.graph(1).setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssCircle, Qt.red, Qt.white, 7))
        self.customPlot.graph(1).setName("Bottom maxwell function")
        # TODO
        #errorBars = QCPErrorBars(self.customPlot.xAxis, self.customPlot.yAxis)
        #errorBars.removeFromLegend()
        #errorBars.setDataPlottable(self.customPlot.graph(1))

        # setup for graph 2: key axis top, value axis right
        # will contain high frequency sine with low frequency beating:
        self.customPlot.addGraph(self.customPlot.xAxis2, self.customPlot.yAxis2)
        self.customPlot.graph(2).setPen(QPen(Qt.blue))
        self.customPlot.graph(2).setName("High frequency sine")

        # setup for graph 3: same axes as graph 2
        # will contain low frequency beating envelope of graph 2
        self.customPlot.addGraph(self.customPlot.xAxis2, self.customPlot.yAxis2)
        blueDotPen = QPen()
        blueDotPen.setColor(QColor(30, 40, 255, 150))
        blueDotPen.setStyle(Qt.DotLine)
        blueDotPen.setWidthF(4)
        self.customPlot.graph(3).setPen(blueDotPen)
        self.customPlot.graph(3).setName("Sine envelope")

        # setup for graph 4: key axis right, value axis top
        # will contain parabolically distributed data points with some random perturbance
        self.customPlot.addGraph(self.customPlot.yAxis2, self.customPlot.xAxis2)
        self.customPlot.graph(4).setPen(QColor(50, 50, 50, 255))
        self.customPlot.graph(4).setLineStyle(QCPGraph.lsNone)
        self.customPlot.graph(4).setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssCircle, 4))
        self.customPlot.graph(4).setName("Some random data around\na quadratic function")

        # generate data, just playing with numbers, not much to learn here:
        x0, y0 = [], []
        x1, y1, y1err = [], [], []
        x2, y2 = [], []
        x3, y3 = [], []
        x4, y4 = [], []
        for i in range(25): # data for graph 0
            x0.append(3*i/25.0)
            y0.append(math.exp(-x0[i]*x0[i]*0.8)*(x0[i]*x0[i]+x0[i]))
        for i in range(15): # data for graph 1
            x1.append(3*i/15.0)
            y1.append(math.exp(-x1[i]*x1[i])*(x1[i]*x1[i])*2.6)
            y1err.append(y1[i]*0.25)
        for i in range(250): # data for graphs 2, 3 and 4
            x2.append(i/250.0*3*math.pi)
            x3.append(x2[i])
            x4.append(i/250.0*100-50)
            y2.append(math.sin(x2[i]*12)*math.cos(x2[i])*10)
            y3.append(math.cos(x3[i])*10)
            y4.append(0.01*x4[i]*x4[i] + 1.5*(random.random()-0.5) + 1.5*math.pi)

        # pass data points to graphs:
        self.customPlot.graph(0).setData(x0, y0)
        self.customPlot.graph(1).setData(x1, y1)
        # TODO
        #errorBars.setData(y1err)
        self.customPlot.graph(2).setData(x2, y2)
        self.customPlot.graph(3).setData(x3, y3)
        self.customPlot.graph(4).setData(x4, y4)
        # activate top and right axes, which are invisible by default:
        self.customPlot.xAxis2.setVisible(True)
        self.customPlot.yAxis2.setVisible(True)
        # set ranges appropriate to show data:
        self.customPlot.xAxis.setRange(0, 2.7)
        self.customPlot.yAxis.setRange(0, 2.6)
        self.customPlot.xAxis2.setRange(0, 3.0*math.pi)
        self.customPlot.yAxis2.setRange(-70, 35)
        # set pi ticks on top axis:
        self.customPlot.xAxis2.setTicker(QCPAxisTickerPi())
        # add title layout element:
        self.customPlot.plotLayout().insertRow(0)
        self.customPlot.plotLayout().addElement(0, 0, QCPTextElement(self.customPlot, "Way too many graphs in one plot", QFont("sans", 12, QFont.Bold)))
        # set labels:
        self.customPlot.xAxis.setLabel("Bottom axis with outward ticks")
        self.customPlot.yAxis.setLabel("Left axis label")
        self.customPlot.xAxis2.setLabel("Top axis label")
        self.customPlot.yAxis2.setLabel("Right axis label")
        # make ticks on bottom axis go outward:
        self.customPlot.xAxis.setTickLength(0, 5)
        self.customPlot.xAxis.setSubTickLength(0, 3)
        # make ticks on right axis go inward and outward:
        self.customPlot.yAxis2.setTickLength(3, 3)
        self.customPlot.yAxis2.setSubTickLength(1, 1)

    def setupLogarithmicDemo(self):
        self.demoName = "Logarithmic Demo"

    def setupRealtimeDataDemo(self):
        self.demoName = "Realtime Data Demo"
        self.time = QTime(QTime.currentTime())
        self.lastPointKey = 0.0
        self.frameCount = 0
        self.lastFpsKey = 0

        self.customPlot.addGraph() # blue line
        self.customPlot.graph(0).setPen(QPen(QColor(40, 110, 255)))
        self.customPlot.addGraph() # red line
        self.customPlot.graph(1).setPen(QPen(QColor(255, 110, 40)))

        timeTicker = QCPAxisTickerTime()
        timeTicker.setTimeFormat("%h:%m:%s")
        self.customPlot.xAxis.setTicker(timeTicker)
        self.customPlot.axisRect().setupFullAxesBox()
        self.customPlot.yAxis.setRange(-1.2, 1.2)
        
        # make left and bottom axes transfer their ranges to right and top axes:
        self.customPlot.xAxis.rangeChanged.connect(self.customPlot.xAxis2.setRange)
        self.customPlot.yAxis.rangeChanged.connect(self.customPlot.yAxis2.setRange)
        
        # setup a timer that repeatedly calls MainWindow.realtimeDataSlot:
        self.dataTimer = QTimer()
        self.dataTimer.timeout.connect(self.realtimeDataSlot)
        self.dataTimer.start(0) # Interval 0 means to refresh as fast as possible

    def setupParametricCurveDemo(self):
        self.demoName = "Parametric Curves Demo"
        # create empty curve objects. As they are not adopted by main QCustomPlot an explicit
        # reference must be kept
        self.fermatSpiral1 = QCustomPlot2.QCPCurve(self.customPlot.xAxis, self.customPlot.yAxis)
        self.fermatSpiral2 = QCustomPlot2.QCPCurve(self.customPlot.xAxis, self.customPlot.yAxis)
        self.deltoidRadial = QCustomPlot2.QCPCurve(self.customPlot.xAxis, self.customPlot.yAxis)
        # generate the curve data points:
        pointCount = 501
        dataSpiral1 = [[0.0] * pointCount, [0.0] * pointCount, [0.0] * pointCount]
        dataSpiral2 = [[0.0] * pointCount, [0.0] * pointCount, [0.0] * pointCount]
        dataDeltoid = [[0.0] * pointCount, [0.0] * pointCount, [0.0] * pointCount]
        for i in range(0, pointCount):
            phi = i/(pointCount-1) * 8 * math.pi
            theta = i/(pointCount-1) * 2 * math.pi
            dataSpiral1[0][i] = float(i)
            dataSpiral1[1][i] = math.sqrt(phi) * math.cos(phi)
            dataSpiral1[2][i] = math.sqrt(phi) * math.sin(phi)
            dataSpiral2[0][i] = float(i)
            dataSpiral2[1][i] = -dataSpiral1[1][i]
            dataSpiral2[2][i] = -dataSpiral1[2][i]
            dataDeltoid[0][i] = float(i)
            dataDeltoid[1][i] = 2 * math.cos(2*theta) + math.cos(1*theta) + 2 * math.sin(theta)
            dataDeltoid[2][i] = 2 * math.sin(2*theta) - math.sin(1*theta)

        # pass the data to the curves we know t (i in loop above) is ascending, so set alreadySorted=true (saves an extra internal sort):
        self.fermatSpiral1.setData(dataSpiral1[0], dataSpiral1[1], dataSpiral1[2], True)
        self.fermatSpiral2.setData(dataSpiral2[0], dataSpiral2[1], dataSpiral2[2], True)
        self.deltoidRadial.setData(dataDeltoid[0], dataDeltoid[1], dataDeltoid[2], True)
        # color the curves:
        self.fermatSpiral1.setPen(QPen(Qt.blue))
        self.fermatSpiral1.setBrush(QBrush(QColor(0, 0, 255, 20)))
        self.fermatSpiral2.setPen(QPen(QColor(255, 120, 0)))
        self.fermatSpiral2.setBrush(QBrush(QColor(255, 120, 0, 30)))
        radialGrad = QRadialGradient(QPointF(310, 180), 200)
        radialGrad.setColorAt(0, QColor(170, 20, 240, 100))
        radialGrad.setColorAt(0.5, QColor(20, 10, 255, 40))
        radialGrad.setColorAt(1, QColor(120, 20, 240, 10))
        self.deltoidRadial.setPen(QPen(QColor(170, 20, 240)))
        self.deltoidRadial.setBrush(QBrush(radialGrad))
        # set some basic customPlot config:
        self.customPlot.setInteractions(QCustomPlot2.QCP.Interactions(QCustomPlot2.QCP.iRangeDrag or QCustomPlot2.QCP.iRangeZoom or QCustomPlot2.QCP.iSelectPlottables))
        self.customPlot.axisRect().setupFullAxesBox()
        self.customPlot.rescaleAxes()

    def setupBarChartDemo(self):
        self.demoName = "Bar Chart Demo"

    def setupStatisticalDemo(self):
        self.demoName = "Statistical Demo"

    def setupSimpleItemDemo(self):
        self.demoName = "Simple Item Demo"

    def setupItemDemo(self):
        self.demoName = "Item Demo"
        self.frameCount = 0
        self.lastFpsKey = 0
        self.customPlot.setInteractions(QCP.iRangeDrag or QCP.iRangeZoom)
        graph = self.customPlot.addGraph()
        n = 500
        phase = 0.0
        k = 3.0
        x, y = [], []
        for i in range(n):
            x.append(i/float((n-1)*34 - 17))
            y.append(math.exp(-x[i]*x[i]/20.0)*math.sin(k*x[i]+phase))
        graph.setData(x, y)
        graph.setPen(QPen(Qt.blue))
        graph.rescaleKeyAxis()
        self.customPlot.yAxis.setRange(-1.45, 1.65)
        self.customPlot.xAxis.grid().setZeroLinePen(QPen(Qt.NoPen))

        # add the bracket at the top:
        bracket = QCPItemBracket(self.customPlot)
        bracket.left.setCoords(-8, 1.1)
        bracket.right.setCoords(8, 1.1)
        bracket.setLength(13)

        # add the text label at the top:
        wavePacketText = QCPItemText(self.customPlot)
        wavePacketText.position.setParentAnchor(bracket.center)
        wavePacketText.position.setCoords(0, -10) # move 10 pixels to the top from bracket center anchor
        wavePacketText.setPositionAlignment(Qt.AlignBottom or Qt.AlignHCenter)
        wavePacketText.setText("Wavepacket")
        wavePacketText.setFont(QFont(QFont().family(), 10))

        # add the phase tracer (red circle) which sticks to the graph data (and gets updated in bracketDataSlot by timer event):
        phaseTracer = QCPItemTracer(self.customPlot)
        self.itemDemoPhaseTracer = phaseTracer # so we can access it later in the bracketDataSlot for animation
        phaseTracer.setGraph(graph)
        phaseTracer.setGraphKey((math.pi*1.5-phase)/k)
        phaseTracer.setInterpolating(True)
        phaseTracer.setStyle(QCPItemTracer.tsCircle)
        phaseTracer.setPen(QPen(Qt.red))
        phaseTracer.setBrush(QBrush(Qt.red))
        phaseTracer.setSize(7)

        # add label for phase tracer:
        phaseTracerText = QCPItemText(self.customPlot)
        phaseTracerText.position.setType(QCPItemPosition.ptAxisRectRatio)
        phaseTracerText.setPositionAlignment(Qt.AlignRight or Qt.AlignBottom)
        phaseTracerText.position.setCoords(1.0, 0.95) # lower right corner of axis rect
        phaseTracerText.setText("Points of fixed\nphase define\nphase velocity vp")
        phaseTracerText.setTextAlignment(Qt.AlignLeft)
        phaseTracerText.setFont(QFont(QFont().family(), 9))
        phaseTracerText.setPadding(QMargins(8, 0, 0, 0))

        # add arrow pointing at phase tracer, coming from label:
        phaseTracerArrow = QCPItemCurve(self.customPlot)
        phaseTracerArrow.start.setParentAnchor(phaseTracerText.left)
        phaseTracerArrow.startDir.setParentAnchor(phaseTracerArrow.start)
        phaseTracerArrow.startDir.setCoords(-40, 0) # direction 30 pixels to the left of parent anchor (tracerArrow.start)
        phaseTracerArrow.end.setParentAnchor(phaseTracer.position)
        phaseTracerArrow.end.setCoords(10, 10)
        phaseTracerArrow.endDir.setParentAnchor(phaseTracerArrow.end)
        phaseTracerArrow.endDir.setCoords(30, 30)
        phaseTracerArrow.setHead(QCPLineEnding(QCPLineEnding.esSpikeArrow))
        phaseTracerArrow.setTail(QCPLineEnding(QCPLineEnding.esBar, (phaseTracerText.bottom.pixelPosition().y()-phaseTracerText.top.pixelPosition().y())*0.85))

        # add the group velocity tracer (green circle):
        groupTracer = QCPItemTracer(self.customPlot)
        groupTracer.setGraph(graph)
        groupTracer.setGraphKey(5.5)
        groupTracer.setInterpolating(True)
        groupTracer.setStyle(QCPItemTracer.tsCircle)
        groupTracer.setPen(QPen(Qt.green))
        groupTracer.setBrush(QBrush(Qt.green))
        groupTracer.setSize(7)

        # add label for group tracer:
        groupTracerText = QCPItemText(self.customPlot)
        groupTracerText.position.setType(QCPItemPosition.ptAxisRectRatio)
        groupTracerText.setPositionAlignment(Qt.AlignRight or Qt.AlignTop)
        groupTracerText.position.setCoords(1.0, 0.20) # lower right corner of axis rect
        groupTracerText.setText("Fixed positions in\nwave packet define\ngroup velocity vg")
        groupTracerText.setTextAlignment(Qt.AlignLeft)
        groupTracerText.setFont(QFont(QFont().family(), 9))
        groupTracerText.setPadding(QMargins(8, 0, 0, 0))

        # add arrow pointing at group tracer, coming from label:
        groupTracerArrow = QCPItemCurve(self.customPlot)
        groupTracerArrow.start.setParentAnchor(groupTracerText.left)
        groupTracerArrow.startDir.setParentAnchor(groupTracerArrow.start)
        groupTracerArrow.startDir.setCoords(-40, 0) # direction 30 pixels to the left of parent anchor (tracerArrow.start)
        groupTracerArrow.end.setCoords(5.5, 0.4)
        groupTracerArrow.endDir.setParentAnchor(groupTracerArrow.end)
        groupTracerArrow.endDir.setCoords(0, -40)
        groupTracerArrow.setHead(QCPLineEnding(QCPLineEnding.esSpikeArrow))
        groupTracerArrow.setTail(QCPLineEnding(QCPLineEnding.esBar, (groupTracerText.bottom.pixelPosition().y()-groupTracerText.top.pixelPosition().y())*0.85))

        # add dispersion arrow:
        arrow = QCPItemCurve(self.customPlot)
        arrow.start.setCoords(1, -1.1)
        arrow.startDir.setCoords(-1, -1.3)
        arrow.endDir.setCoords(-5, -0.3)
        arrow.end.setCoords(-10, -0.2)
        arrow.setHead(QCPLineEnding(QCPLineEnding.esSpikeArrow))

        # add the dispersion arrow label:
        dispersionText = QCPItemText(self.customPlot)
        dispersionText.position.setCoords(-6, -0.9)
        dispersionText.setRotation(40)
        dispersionText.setText("Dispersion with\nvp < vg")
        dispersionText.setFont(QFont(QFont().family(), 10))

        # setup a timer that repeatedly calls MainWindow.bracketDataSlot:
        self.dataTimer = QTimer()
        self.dataTimer.timeout.connect(self.bracketDataSlot)
        self.dataTimer.start(0) # Interval 0 means to refresh as fast as possible

    def setupStyledDemo(self):
        self.demoName = "Styled Demo"
        # add two new graphs and set their look:
        # prepare data:
        x1, y1 = [], []
        x2, y2 = [], []
        x3, y3 = [], []
        x4, y4 = [], []
        for i in range(20):
            x1.append(i/float(20-1)*10)
            y1.append(math.cos(x1[i]*0.8+math.sin(x1[i]*0.16+1.0))*math.sin(x1[i]*0.54)+1.4)
        for i in range(100):
            x2.append(i/float(100-1)*10)
            y2.append(math.cos(x2[i]*0.85+math.sin(x2[i]*0.165+1.1))*math.sin(x2[i]*0.50)+1.7)
        for i in range(20):
            x3.append(i/float(20-1)*10)
            y3.append(0.05+3*(0.5+math.cos(x3[i]*x3[i]*0.2+2)*0.5)/float(x3[i]+0.7)+random.random()*0.01)
        for i in range(20):
            x4.append(x3[i])
            y4.append((0.5-y3[i])+((x4[i]-2)*(x4[i]-2)*0.02))
        
        # create and configure plottables:
        graph1 = self.customPlot.addGraph()
        graph1.setData(x1, y1)
        graph1.setScatterStyle(QCPScatterStyle(QCPScatterStyle.ssCircle, QPen(Qt.black, 1.5), QBrush(Qt.white), 9))
        graph1.setPen(QPen(QColor(120, 120, 120), 2))
        
        graph2 = self.customPlot.addGraph()
        graph2.setData(x2, y2)
        graph2.setPen(QPen(Qt.NoPen))
        graph2.setBrush(QColor(200, 200, 200, 20))
        graph2.setChannelFillGraph(graph1)
        
        bars1 = QCPBars(self.customPlot.xAxis, self.customPlot.yAxis)
        bars1.setWidth(9/float(len(x3)))
        bars1.setData(x3, y3)
        bars1.setPen(QPen(Qt.NoPen))
        bars1.setBrush(QColor(10, 140, 70, 160))
        
        bars2 = QCPBars(self.customPlot.xAxis, self.customPlot.yAxis)
        bars2.setWidth(9/float(len((x4))))
        bars2.setData(x4, y4)
        bars2.setPen(QPen(Qt.NoPen))
        bars2.setBrush(QColor(10, 100, 50, 70))
        bars2.moveAbove(bars1)
        
        # move bars above graphs and grid below bars:
        self.customPlot.addLayer("abovemain", self.customPlot.layer("main"), QCustomPlot.limAbove)
        self.customPlot.addLayer("belowmain", self.customPlot.layer("main"), QCustomPlot.limBelow)
        graph1.setLayer("abovemain")
        self.customPlot.xAxis.grid().setLayer("belowmain")
        self.customPlot.yAxis.grid().setLayer("belowmain")
        
        # set some pens, brushes and backgrounds:
        self.customPlot.xAxis.setBasePen(QPen(Qt.white, 1))
        self.customPlot.yAxis.setBasePen(QPen(Qt.white, 1))
        self.customPlot.xAxis.setTickPen(QPen(Qt.white, 1))
        self.customPlot.yAxis.setTickPen(QPen(Qt.white, 1))
        self.customPlot.xAxis.setSubTickPen(QPen(Qt.white, 1))
        self.customPlot.yAxis.setSubTickPen(QPen(Qt.white, 1))
        self.customPlot.xAxis.setTickLabelColor(Qt.white)
        self.customPlot.yAxis.setTickLabelColor(Qt.white)
        self.customPlot.xAxis.grid().setPen(QPen(QColor(140, 140, 140), 1, Qt.DotLine))
        self.customPlot.yAxis.grid().setPen(QPen(QColor(140, 140, 140), 1, Qt.DotLine))
        self.customPlot.xAxis.grid().setSubGridPen(QPen(QColor(80, 80, 80), 1, Qt.DotLine))
        self.customPlot.yAxis.grid().setSubGridPen(QPen(QColor(80, 80, 80), 1, Qt.DotLine))
        self.customPlot.xAxis.grid().setSubGridVisible(True)
        self.customPlot.yAxis.grid().setSubGridVisible(True)
        self.customPlot.xAxis.grid().setZeroLinePen(QPen(Qt.NoPen))
        self.customPlot.yAxis.grid().setZeroLinePen(QPen(Qt.NoPen))
        self.customPlot.xAxis.setUpperEnding(QCPLineEnding(QCPLineEnding.esSpikeArrow))
        self.customPlot.yAxis.setUpperEnding(QCPLineEnding(QCPLineEnding.esSpikeArrow))
        plotGradient = QLinearGradient()
        plotGradient.setStart(0, 0)
        plotGradient.setFinalStop(0, 350)
        plotGradient.setColorAt(0, QColor(80, 80, 80))
        plotGradient.setColorAt(1, QColor(50, 50, 50))
        self.customPlot.setBackground(plotGradient)
        axisRectGradient = QLinearGradient()
        axisRectGradient.setStart(0, 0)
        axisRectGradient.setFinalStop(0, 350)
        axisRectGradient.setColorAt(0, QColor(80, 80, 80))
        axisRectGradient.setColorAt(1, QColor(30, 30, 30))
        self.customPlot.axisRect().setBackground(axisRectGradient)
        
        self.customPlot.rescaleAxes()
        self.customPlot.yAxis.setRange(0, 2)

    def setupAdvancedAxesDemo(self):
        self.demoName = "Advanced Axes Demo"
        
    def setupColorMapDemo(self):
        # configure axis rect:
        self.customPlot.setInteractions(QCP.iRangeDrag or QCP.iRangeZoom) # this will also allow rescaling the color scale by dragging/zooming
        self.customPlot.axisRect().setupFullAxesBox(True)
        self.customPlot.xAxis.setLabel("x")
        self.customPlot.yAxis.setLabel("y")
        
        # set up the QCPColorMap:
        colorMap = QCPColorMap(self.customPlot.xAxis, self.customPlot.yAxis)
        nx = 200
        ny = 200
        colorMap.data().setSize(nx, ny) # we want the color map to have nx * ny data points
        colorMap.data().setRange(QCPRange(-4, 4), QCPRange(-4, 4)) # and span the coordinate range -4..4 in both key (x) and value (y) dimensions
        # now we assign some data, by accessing the QCPColorMapData instance of the color map:
        for xIndex in range(nx):
            for yIndex in range(ny):
                x, y = colorMap.data().cellToCoord(xIndex, yIndex)
                r = 3*math.sqrt(x*x+y*y)+1e-2
                z = 2*x*(math.cos(r+2)/r-math.sin(r+2)/r) # the B field strength of dipole radiation (modulo physical constants)
                colorMap.data().setCell(xIndex, yIndex, z)
        
        # add a color scale:
        colorScale = QCPColorScale(self.customPlot)
        self.customPlot.plotLayout().addElement(0, 1, colorScale) # add it to the right of the main axis rect
        colorScale.setType(QCPAxis.atRight) # scale shall be vertical bar with tick/axis labels right (actually atRight is already the default)
        colorMap.setColorScale(colorScale) # associate the color map with the color scale
        colorScale.axis().setLabel("Magnetic Field Strength")
        
        # set the color gradient of the color map to one of the presets:
        colorMap.setGradient(QCPColorGradient(QCPColorGradient.gpPolar))
        # we could have also created a QCPColorGradient instance and added own colors to
        # the gradient, see the documentation of QCPColorGradient for what's possible.
        
        # rescale the data dimension (color) such that all data points lie in the span visualized by the color gradient:
        colorMap.rescaleDataRange()
        
        # make sure the axis rect and color scale synchronize their bottom and top margins (so they line up):
        marginGroup = QCPMarginGroup(self.customPlot)
        self.customPlot.axisRect().setMarginGroup(QCP.msBottom or QCP.msTop, marginGroup)
        colorScale.setMarginGroup(QCP.msBottom or QCP.msTop, marginGroup)
        
        # rescale the key (x) and value (y) axes so the whole color map is visible:
        self.customPlot.rescaleAxes()

    def setupFinancialDemo(self):
        self.tmp = 0

#   void setupPlayground(QCustomPlot *customPlot)

    def realtimeDataSlot(self):
        #static QTime time(QTime.currentTime())
        # calculate two new data points:
        key = self.time.elapsed()/1000.0 # time elapsed since start of demo, in seconds
        if key-self.lastPointKey > 0.002: # at most add point every 2 ms
            # add data to lines:
            self.customPlot.graph(0).addData(key, math.sin(key)+random.random()*1*math.sin(key/0.3843))
            self.customPlot.graph(1).addData(key, math.cos(key)+random.random()*0.5*math.sin(key/0.4364))
            # rescale value (vertical) axis to fit the current data:
            #self.customPlot.graph(0).rescaleValueAxis()
            #self.customPlot.graph(1).rescaleValueAxis(true)
            self.lastPointKey = key
        # make key axis range scroll with the data (at a constant range size of 8):
        self.customPlot.xAxis.setRange(key, 8, Qt.AlignRight)
        self.customPlot.replot()

        # calculate frames per second:
        self.frameCount += 1
        if key-self.lastFpsKey > 2: # average fps over 2 seconds
            self.statusBar.showMessage(
                f"{self.frameCount/(key-self.lastFpsKey)} FPS, Total Data points: {self.customPlot.graph(0).data().size()+self.customPlot.graph(1).data().size()}")
            self.lastFpsKey = key
            self.frameCount = 0

    def bracketDataSlot(self):
        secs = QCPAxisTickerDateTime.dateTimeToKey(QDateTime.currentDateTime())

        # update data to make phase move:
        n = 500
        phase = secs*5.0
        k = 3.0
        x, y = [], []
        for i in range(n):
            x.append(i/float((n-1)*34 - 17))
            y.append(math.exp(-x[i]*x[i]/20.0)*math.sin(k*x[i]+phase))
        self.customPlot.graph().setData(x, y)

        self.itemDemoPhaseTracer.setGraphKey((8*math.pi+math.fmod(math.pi*1.5-phase, 6*math.pi))/k)

        self.customPlot.replot()

        # calculate frames per second:
        key = secs
        self.frameCount += 1
        if key-self.lastFpsKey > 2: # average fps over 2 seconds
            self.statusBar.showMessage(
                f"{self.frameCount/(key-self.lastFpsKey)} FPS, Total Data points: {self.customPlot.graph(0).data().size()}")
            self.lastFpsKey = key
            self.frameCount = 0
