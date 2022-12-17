"""The build configuration file for QCustomPlot, used by sip."""

import os
import platform
from os.path import join
from sipbuild import Option
from pyqtbuild import PyQtBindings, PyQtProject


# Number of parallel compilations
CPU_COUNT = os.cpu_count() if 'cpu_count' in dir(os) else 1


class QCustomPlotProject(PyQtProject):
    """The QCustomPlot Project class."""

    def __init__(self):
        super().__init__()
        self.bindings_factories = [QCustomPlotBindings]

    def update(self, tool):
        """Update some metadata to build module for various PyQt versions."""
        super().update(tool)

        # Check if module name and Qt version are in agreement
        if tool != 'sdist' and self.name.endswith('PyQt6') and self.builder.qt_version < 0x060000:
            print('\nTrying to build QCustomPlot_PyQt6 module, but Qt5 is found.\n'
                  'Use \'--qmake _path_to_qmake6_\' option or change module name.\n')
            exit(1)

        # Determine Qt version to use
        use_pyqt6 = False
        if self.name.endswith('PyQt6'):  # if module name was specified
            use_pyqt6 = True
        elif self.builder.qt_version >= 0x060000:  # else use qmake version
            use_pyqt6 = True

        if use_pyqt6:
            import PyQt6 as PyQt
            self.abi_version = '13'  # set ABI version for better compatibility
        else:
            import PyQt5 as PyQt
            self.abi_version = '12'  # set ABI version for better compatibility

        print('\nBuilding QCustomPlot_{} module.\n'.format(PyQt.__name__))
        self.sip_include_dirs.append(join(PyQt.__path__[0], 'bindings'))

        # Need to update some metadata if building module for PyQt6
        self.name = 'QCustomPlot_{}'.format(PyQt.__name__)
        self._metadata_overrides = {'name': self.name,
                                    'requires-dist': PyQt.__name__}
        for key, value in self._metadata_overrides.items():
            self.metadata[key] = value

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
        """Make static qcustomplot library to be linked
        into python module if necessary.
        """
        if not self.bindings['QCustomPlot'].static_qcustomplot:
            print('\nUsing system-wide QCustomPlot library.\n')
            return

        print('\nMaking static qcustomplot library...\n')
        cwd = os.getcwd()
        os.makedirs(join(self.root_dir, self.build_dir, 'qcustomplot'),
                    exist_ok=True)
        os.chdir(join(self.root_dir, self.build_dir, 'qcustomplot'))

        self.run_command([self.builder.qmake,
                          join(self.root_dir, 'src/qcp-staticlib.pro')])
        if platform.system() == 'Windows':
            # Prefer jom instead of nmake
            self.run_command(['jom.exe'])
        else:
            self.run_command(['make', '-j', str(CPU_COUNT)])

        os.chdir(cwd)


class QCustomPlotBindings(PyQtBindings):
    """The QCustomPlot Bindings class."""

    def __init__(self, project):
        super().__init__(project,
                         name='QCustomPlot',
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
                   help='disable use of internal static QCustomPlot library'
                   'and prefer system-wide',
                   option_type=bool,
                   inverted=True),
            Option('qcustomplot_lib',
                   help='the name of QCustomPlot library to link with'
                   ' (default is qcustomplot)',
                   metavar='NAME',
                   default='qcustomplot'),
        ]
        return options

    def apply_user_defaults(self, tool):
        """Apply values from user-configurable options."""
        super().apply_user_defaults(tool)

        self.sip_file = 'all_PyQt{}.sip'.format(self.project.builder.qt_version >> 16)

        self.include_dirs.append(join(self.project.root_dir, 'sip'))
        if self.static_qcustomplot:
            self.include_dirs.append(join(self.project.root_dir, 'src'))

        self.libraries.append(self.qcustomplot_lib)
        if platform.system() == 'Windows':
            self.libraries.append('opengl32')

        if self.static_qcustomplot:
            if platform.system() == 'Windows':
                self.library_dirs.append(join(self.project.root_dir,
                                              self.project.build_dir,
                                              'qcustomplot', 'release'))
            else:
                self.library_dirs.append(join(self.project.root_dir,
                                              self.project.build_dir,
                                              'qcustomplot'))

        if self.qt_incdir is not None:
            self.include_dirs.append(self.qt_incdir)
        if self.qt_libdir is not None:
            self.library_dirs.append(self.qt_libdir)
