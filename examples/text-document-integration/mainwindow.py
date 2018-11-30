#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.0.0
#
# Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http://www.qcustomplot.com

import math

from PyQt5.QtCore import QTimer, QPointF, Qt
from PyQt5.QtGui import QPen, QBrush, QColor, QRadialGradient
from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi

import QCustomPlot2

from QCustomPlot2 import QCP

class MainWindow(QMainWindow):
    def __init__(self, argv, parent=None):
        super().__init__(parent)
        loadUi("examples/text-document-integration/mainwindow.ui", self)