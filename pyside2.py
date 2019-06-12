import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, QQmlFileSelector

sys_argv = sys.argv
#sys_argv += ['--style', 'material']
app = QGuiApplication(sys_argv)

window = QQmlApplicationEngine()

window.load("qml/win_/win.qml")



app.exec_()