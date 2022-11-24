"""The build configuration file for QCustomPlot, used by sip."""

import os
import platform
import subprocess
from os.path import join
from sipbuild import Option
from pyqtbuild import PyQtBindings, PyQtProject
import PyQt5


CPU_COUNT = os.cpu_count() if 'cpu_count' in dir(os) else 1  # number of parallel compilations


class QCustomPlotProject(PyQtProject):
    """The QCustomPlot Project class."""

    def __init__(self):
        super().__init__()
        self.bindings_factories = [QCustomPlotBindings]

    def update(self, tool):
        """Allows SIP to find PyQt5 .sip files."""
        super().update(tool)
        self.sip_include_dirs.append(join(PyQt5.__path__[0], 'bindings'))

    def build(self):
        self.build_qcustomplot()
        super().build()

    def build_wheel(self, wheel_directory):
        self.build_qcustomplot()
        super().build_wheel(wheel_directory)

    def install(self):
        self.build_qcustomplot()
        super().install()

    def build_qcustomplot(self):
        """Make static qcustomplot library to be linked into python module if necessary."""
        if not self.bindings['QCustomPlot2'].static_qcustomplot:
            print('\nUsing system-wide QCustomPlot library.\n')
            return

        print('\nMaking static qcustomplot library...\n')
        cwd = os.getcwd()
        os.makedirs(join(self.root_dir, self.build_dir, 'qcustomplot'), exist_ok=True)
        os.chdir(join(self.root_dir, self.build_dir, 'qcustomplot'))

        self.run_command([self.builder.qmake,
                          join(self.root_dir, 'src/qcp-staticlib.pro'),
                          'DESTDIR='])
        if platform.system() == 'Windows':
            # Prefer jom instead of nmake
            self.run_command(['jom.exe'])
        else:
            self.run_command(['make', 'DESTDIR=', '-j', str(CPU_COUNT)])

        os.chdir(cwd)


class QCustomPlotBindings(PyQtBindings):
    """The QCustomPlot Bindings class."""

    def __init__(self, project):
        super().__init__(project,
                         name='QCustomPlot2',
                         sip_file='all.sip',
                         qmake_QT=['widgets', 'printsupport'],
                         internal=True)

    def get_options(self):
        """Our custom options that a user can pass to sip-build."""
        options = super().get_options()

        options += [
            Option('qt_incdir',
                   help='path to Qt headers',
                   metavar='DIR'),
            Option('qt_libdir',
                   help='path to Qt library dir (used at link time)',
                   metavar='DIR'),
            Option('static_qcustomplot',
                   help='disable use of internal static QCustomPlot library and prefer system-wide',
                   option_type=bool,
                   inverted=True),
            Option('qcustomplot_lib',
                   help='the name of QCustomPlot library to link with (default is qcustomplot)',
                   metavar='NAME',
                   default='qcustomplot'),
        ]
        return options

    def apply_user_defaults(self, tool):
        """Apply values from user-configurable options."""
        super().apply_user_defaults(tool)

        self.include_dirs.append(join(self.project.root_dir, 'sip'))
        if self.static_qcustomplot:
            self.include_dirs.append(join(self.project.root_dir, 'src'))

        self.libraries.append(self.qcustomplot_lib)
        if platform.system() == 'Windows':
            self.libraries.append('opengl32')

        if self.static_qcustomplot:
            if platform.system() == 'Windows':
                self.library_dirs.append(join(self.project.root_dir, self.project.build_dir, 'qcustomplot', 'release'))
            else:
                self.library_dirs.append(join(self.project.root_dir, self.project.build_dir, 'qcustomplot'))

        if self.qt_incdir is not None:
            self.include_dirs.append(self.qt_incdir)
        if self.qt_libdir is not None:
            self.library_dirs.append(self.qt_libdir)
