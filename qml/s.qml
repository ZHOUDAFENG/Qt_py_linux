
import QtQuick 2.9
//主线啊

Rectangle {
    id:mainbox
    width: 1000
    height: 600
    //灰色0.9透明度
    color:Qt.rgba(0.6,0.5,0.8,0.0)
    MouseArea {
        id: dragRegion
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
            }
        onPositionChanged: {
        //鼠标偏移量
        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
        //如果mainwindow继承自QWidget,用setPos
        mainwindow.setX(mainwindow.x+delta.x)
        mainwindow.setY(mainwindow.y+delta.y)
        }
    }
    
    AnimatedImage {
        id: animated;
        opacity: 0.4
        source: "../img/1.gif"
    }

    //要置于MouseArea之后，否则无法响应鼠标点击
    Rectangle{

        id:closeBtn1
        height: 30
        width: 50
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        color:Qt.rgba(0.6,0.1,0.2,0.7)
        Text{
            text:"X"
            anchors.centerIn: parent
            color:"#ffffff"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:
            {
                Qt.quit()//无法关闭窗口
                //mainwindow.close()
                
                
            }
        }
    }
     Rectangle{

        id:closeBtn2
        height: 30
        width: 50
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 5
        color:Qt.rgba(0.4,0.4,0.2,0.7)
        Text{
            text:"on"
            anchors.centerIn: parent
            color:"#ffffff"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:
            {
                //Qt.quit()//无法关闭窗口
               mainbox.color=Qt.rgba(0.1,0.1,0.4,0.4)
               onClicked: animated.paused = !animated.paused;
               onClicked: animated.source = "../img/1.gif";
            }
        }
    }
    Rectangle{

        id:closeBtn3
        height: 30
        width: 50
        anchors.right: parent.right
        anchors.rightMargin: 60+55
        anchors.top: parent.top
        anchors.topMargin: 5
        color:Qt.rgba(0.3,0.4,0.2,0.6)
        Text{
            text:"off"
            anchors.centerIn: parent
            color:"#ffffff"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:
            {
                //Qt.quit()//无法关闭窗口
                onClicked: animated.source = "../img/2.gif";
                mainbox.color=Qt.rgba(0.9,0.5,0.9,0.5)
            }
        }
    }
}