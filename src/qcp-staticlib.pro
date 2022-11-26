#
#  Project to compile QCustomPlot as static library (.a/.lib) from the amalgamated sources
#

QT += core gui
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

greaterThan(QT_MAJOR_VERSION, 4): CONFIG += c++11
lessThan(QT_MAJOR_VERSION, 5): QMAKE_CXXFLAGS += -std=c++11

TEMPLATE = lib
CONFIG += qt staticlib debug_and_release build_all

!win32 {
  QMAKE_CXXFLAGS += -Wall -Wextra
  QMAKE_CXXFLAGS += -Wold-style-cast -Wlogical-op -Wduplicated-branches -Wduplicated-cond
}

VERSION = 2.1.1
TARGET = qcustomplot
CONFIG(debug, debug|release) {
  TARGET = $$join(TARGET,,,d) # if compiling in debug mode, append a "d" to the library name
  MOC_DIR = build-debug
  OBJECTS_DIR = build-debug
} else {
  MOC_DIR = build-release
  OBJECTS_DIR = build-release
}

SOURCES += qcustomplot.cpp
HEADERS += qcustomplot.h
