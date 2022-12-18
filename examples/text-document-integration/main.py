#!/usr/bin/env python
# -*- coding: utf-8 -*-

# PyQt5 binding for QCustomPlot v2.1.1
#
# Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
# License: MIT
#
# QCustomPlot author: Emanuel Eichhammer
# QCustomPlot Website/Contact: http://www.qcustomplot.com

import sys

from PyQt5.QtWidgets import QApplication

import mainwindow

def main():
    app = QApplication(sys.argv)
    w = mainwindow.MainWindow(sys.argv)
    w.show()
    return app.exec()


if __name__ == '__main__':
    sys.exit(main())
