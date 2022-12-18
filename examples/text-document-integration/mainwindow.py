#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.1.1
#
# Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http://www.qcustomplot.com

from PyQt5.QtWidgets import QMainWindow
from PyQt5.uic import loadUi

from QCustomPlot_PyQt5 import QCP

class MainWindow(QMainWindow):
    def __init__(self, argv, parent=None):
        super().__init__(parent)
        loadUi("mainwindow.ui", self)
