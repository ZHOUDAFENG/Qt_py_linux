
import QtQuick 2.9
//主线啊

Rectangle {
    id:mainbox
    width: 1200
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
  /*
    AnimatedImage {
        id: animated
        anchors.top: parent.top
        anchors.topMargin:0
        width:200
        height:200
        opacity: 0.1
        source: "../img/1.gif"
    }
    AnimatedImage {
        id: animated2
        anchors.top: parent.top
        anchors.topMargin:200
        width:200
        height:200
        
        opacity: 0.2
        source: "../img/3.gif"
    }
*/
    AnimatedImage {
        id: animated3
        anchors.top: parent.top
        anchors.topMargin:200*2
        width:200
        height:200
        opacity: 0.8
        source: "../img/6.gif"
    }    
    Image {
        id: animated4
        anchors.left:parent.left
        anchors.top: parent.top
        anchors.topMargin:0
        anchors.leftMargin:200
        width:128*3
        height:191*3
        opacity: 1
        source: "../img/2.png"
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
               //animated.paused = !animated.paused;
               //animated.source = "../img/1.gif";
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
                //animated.source = "../img/2.gif";
                mainbox.color=Qt.rgba(0.9,0.5,0.9,0.5)
            }
        }
    }
  Rectangle{

        id:closeBtn4
        height: 30
        width: 50
        anchors.right: parent.right
        anchors.rightMargin: 60+55+55
        anchors.top: parent.top
        anchors.topMargin: 5
        color:Qt.rgba(0.3,0.4,0.2,0.6)
        Text{
            text:"mov"
            anchors.centerIn: parent
            color:"#ffffff"
        }
        MouseArea{
            anchors.fill: parent
            onClicked:
            {
                //Qt.quit()//无法关闭窗口
                //animated.source = "../img/5.gif";
                //animated.paused=false
                mainbox.color=Qt.rgba(0.0,0.0,0.0,0.0)
                mainwindow.setX(mainwindow.x=100)
                mainwindow.setY(mainwindow.y=100)
            }
        }
    }
}