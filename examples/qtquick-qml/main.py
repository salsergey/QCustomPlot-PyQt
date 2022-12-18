#!/usr/bin/env python

import sys
import os.path

from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import qmlRegisterType, QQmlApplicationEngine

sys.path.insert(1, os.path.dirname(os.path.abspath(__file__)))
import qml_rc

from customplot import CustomPlot


app = QApplication(sys.argv)

qmlRegisterType(CustomPlot, 'QCustomPlot', 2, 0, 'CustomPlot')

engine = QQmlApplicationEngine()
engine.load(QUrl('qrc:///main.qml'))

sys.exit(app.exec())
