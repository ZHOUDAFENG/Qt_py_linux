import sys
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, QQmlFileSelector


app = QGuiApplication()

window = QQmlApplicationEngine()

window.load("qml/win_/win.qml")



app.exec_()