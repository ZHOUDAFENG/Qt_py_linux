import QtQuick 2.7
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtMultimedia 5.4

ApplicationWindow {
    id: _window
    opacity: 0.5
    // 窗口标题设置
    title: "视频播放"
    // 窗口大小设置
    width: 930
    height: 350
    flags:Qt.FramelessWindowHint
    // Window默认不可见，需要进行设置为可见
    visible: true


Rectangle {
        
        color: "black"
        anchors.fill: parent
        //opacity: 0.5
        MediaPlayer {
            id: mediaPlayer
            source: "file:///D:/Qt/qml/video/dy.avi"
            autoPlay: true
        }

        VideoOutput {
            id: video
            //opacity: 0.9
            anchors.fill: parent
            source: mediaPlayer
        }
    }

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
}
