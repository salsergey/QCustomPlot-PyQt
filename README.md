# QCustomPlot for PyQt5 and PyQt6

- [Design goals](#design-goals)
- [Installing](#installing)
- [Getting started](#getting-started)
- [Examples](#examples)
- [Supported compilers](#supported-compilers)
- [License](#license)
- [Contact](#contact)
- [Thanks](#thanks)
- [Used third-party tools](#used-third-party-tools)
- [Projects using](#projects-using)
- [Building](#building)

## Design goals

This is Python bindings for [QCustomPlot](https://www.qcustomplot.com) - Qt C++ library for plotting and data visualization. This binding can be complied for use with **PyQ5** or **PyQt6**. There are myriads of Python charting libraries out there, and each may even have its reason to exist. QCustomPlot has the following goals:

- **Performance**. QCustomPlot is written in modern C++ with the excellent Qt library for superior performance over alternative libraries.

- **Flexibility**. QCustomPlot is one of the most customisable libraries available, with a wide range of supported graph types and full control over how the graph is rendered.


## Installing

### Linux

You can find compiled packages for many Linux distributions at [OBS](https://software.opensuse.org//download.html?project=home%3Asergeyopensuse%3Agpxviewer&package=python-qcustomplot2).

### Windows

Install the package via our favourite package manager:

```sh
$ pip install QCustomPlot_PyQt5
```
or

```sh
$ pip install QCustomPlot_PyQt6
```


## Getting started

Now let's take a look at some code:

```python
import sys
import math
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPen, QBrush, QColor
from PyQt5.QtWidgets import QApplication, QMainWindow
from QCustomPlot_PyQt5 import *


app = QApplication(sys.argv)
window = QMainWindow()
window.resize(800, 600)

customPlot = QCustomPlot()
window.setCentralWidget(customPlot)

graph0 = customPlot.addGraph()
graph0.setPen(QPen(Qt.blue))
graph0.setBrush(QBrush(QColor(0, 0, 255, 20)))

graph1 = customPlot.addGraph()
graph1.setPen(QPen(Qt.red))

x, y0, y1 = [], [], []
for i in range (251):
    x.append(i)
    y0.append(math.exp(-i/150.0)*math.cos(i/10.0))  # exponentially decaying cosine
    y1.append(math.exp(-i/150.0))                   # exponential envelope

graph0.setData(x, y0)
graph1.setData(x, y1)

customPlot.rescaleAxes()
customPlot.setInteraction(QCP.iRangeDrag)
customPlot.setInteraction(QCP.iRangeZoom)
customPlot.setInteraction(QCP.iSelectPlottables)

window.show()
sys.exit(app.exec_())
```

That's all!

Some important things:

* QCustomPlot is a QWidget type that can be used the same way as any other widget, added to layouts, etc. However, you can nest multiple graphs in a single QCustomPlot using layouts (see the Advanced Axes demo).


## Examples

Beside the examples below, you may want to check the [documentation](https://www.qcustomplot.com/index.php/support/documentation).


## Supported compilers

The following compilers are known to work:

- MSVC 140, 141
- GCC 4.8
- Clang 3.4

I would be happy to learn about other compilers/versions.


## License

<img align="right" src="http://opensource.org/trademarks/opensource/OSI-Approved-License-100x137.png">

This code is licensed under the [MIT License](http://opensource.org/licenses/MIT):

Copyright &copy; 2017-2019 Dmitry Voronin, Christopher Gilbert and [Sergey Salnikov](https://github.com/salsergey)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

* * *

This project contains the [QCustomPlot](https://gitlab.com/DerManu/QCustomPlot) library from Emanuel Eichhammer which is licensed under the [GPL Version 3 License](http://opensource.org/licenses/GPLv3). Copyright &copy; 2011-2018 [Emanuel Eichhammer](http://bjoern.hoehrmann.de/) <bjoern@hoehrmann.de>


## Contact

If you have questions regarding the library, I would like to invite you to [open an issue at Github](https://github.com/salsergey/QCustomPlot-PyQt/issues/new). Please describe your request, problem, or question as detailed as possible, and also mention the version of the library you are using as well as the version of your compiler and operating system. Opening an issue at GitHub allows other users and contributors to this library to collaborate.


## Thanks

I deeply appreciate the help of the following people.

- [DerManu](https://gitlab.com/DerManu) is the official author and maintainer of the excellent QCustomPlot library.
- [dimv36](https://github.com/dimv36) is the original author of the Python bindings for QCustomPlot 1.0.0, upon which this project is based.
- [cowo78](https://github.com/cowo78) and [cjgdev](https://github.com/cjgdev) added support for the QCustomPlot 2.0.0 API.

Thanks a lot for helping out! Please [let me know](mailto:salsergey@gmail.com) if I forgot someone.


## Used third-party tools

This library is built, tested, documented, and whatnot using third-party tools and services. Thanks a lot!

- [**SIP**](https://www.riverbankcomputing.com/software/sip) to generate the Python bindings.


## Projects using

- [**GPX Viewer**](https://osdn.net/projects/gpxviewer/) --- an application for viewing GPX files as a list of points and tracks.

If you are using QCustomPlot-PyQt5 in a project and would like to share with the community, please let me know, or even better, raise a pull request.


## Building from sources

### Linux

Apt users (Debian, Ubuntu, etc) may follow the instructions below, users of other distributions may adapt the steps below for your own package manager. Qt5 or Qt6 can be used as a dependency.

```sh
# Fetch the necessary development tools and libraries
$ apt-get install build-essential python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools

# Clone the repository and submodules
$ git clone --recursive https://github.com/salsergey/QCustomPlot-PyQt.git && cd QCustomPlot-PyQt

# Build
$ sip-build --qmake _path_to_qmake5_or_qmake6_

# Zzz..

# Install
$ sip-install --qmake _path_to_qmake5_or_qmake6_
```


### Windows

Windows users should install [Qt tools](https://www.qt.io/), appropriate version of [VC compiler](https://visualstudio.microsoft.com/), [Python](https://www.python.org/), [PyQt5](https://www.riverbankcomputing.com/software/pyqt/download5) and [SIP](https://www.riverbankcomputing.com/software/sip/download). You may need to build SIP from sources to ensure you have all files necessary for building other software. Then follow the instructions below to build the library, otherwise you will need to adapt the steps for your own environment.

- Download QCustomPlot-PyQt sources from [Github](https://github.com/salsergey/QCustomPlot-PyQt/releases). You can use git or download an archive.
- Launch Qt console and follow instructions there. It will ensure that you have all necessary tools in your PATH variable. Also be sure that python.exe binary is in your PATH.
- Then follow these instructions:

```cmd
# Go to QCustomPlot folder
cd <<PATH_TO QCustomPlot-PyQt>>

# Download submodules if you use git
git submodules update --init

# Build
sip-build --qmake _path_to_qmake5_or_qmake6_

# Zzz..

# Install
sip-install --qmake _path_to_qmake5_or_qmake6_
```


### macOS

Users of macOS using [homebrew](https://brew.sh/) may follow the instructions below to fetch the required packages to build the library, or simply adapt to your own environment.

```sh
# First ensure Xcode is installed, as homebrew depends on it
$ xcode-select --install

# Fetch the necessary development tools and libraries
$ brew install qt --devel sip --without-python@2 pyqt --without-python@2

# Clone the repository and submodules
$ git clone --recursive https://github.com/salsergey/QCustomPlot-PyQt.git && cd QCustomPlot-PyQt

# Build
$ CFLAGS='-std=c++11 -stdlib=libc++' CXXFLAGS='-std=c++11 -stdlib=libc++' sip-build --qmake _path_to_qmake5_or_qmake6_

# Zzz..

# Install
$ sip-install --qmake _path_to_qmake5_or_qmake6_
```
