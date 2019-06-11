import sys
import time

from PySide2.QtWidgets import QApplication
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QObject, Signal, Slot,QUrl,Qt
from PySide2 import QtGui

class MyClass(QObject):
    @Slot(str)    # 输入参数为str类型
    def outputString(self, string):
        print(string)



app = QApplication([])
app.setWindowIcon(QtGui.QIcon('./img/icon.ico'))

view = QQuickView()

#链接quit 到函数中去
view.engine().quit.connect(app.quit)



#链接函数到mql 用js执行
con = MyClass()
context = view.rootContext()
context.setContextProperty("con", con)
context.setContextProperty("mainwindow",view)
view.setSource(QUrl("./qml/简单.qml"))



#透明和无标题
view.setFlags(Qt.FramelessWindowHint)
view.setColor(Qt.transparent)
view.show()

app.exec_()



