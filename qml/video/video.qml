import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2


Window{
    id:myPlayer
    width: 1024
    height: 650
    visible: true
    title:"MyPlayer:" + getVedioName(fd.fileUrl.toString())
    flags: Qt.Window | Qt.FramelessWindowHint
    property int isMaxStatus //存储窗口是否最大化

    //蒙层
    Mask{
        id: mainWinMask
        visible: false
    }


    //config窗体
    // 弹出层
    ConfigWindow {
        id: cfgWin
        width: 500; height: 250
        x: myPlayer.x + 300; y:myPlayer.y + 150;
        //anchors.centerIn: parent  // 注意：使用位移动画不能用anchors定位方式
        //z: 101
        opacity: 1
        visible: false;
        //radius: 5
        //
        Text{
            text: '--this is myPlayer Config--'
            anchors.bottom: parent.bottom
            anchors.centerIn: parent
        }
        Button {
            id: btnClose
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            text:"Close"
            width: 98
            onClicked: cfgWin.hide()
        }
    }
//    //测试窗体
//    NeedShowWindow{
//        id:needShowWindowPanel
//    }
    //获取影音名称
    function getVedioName(str)
    {
        var url=fd.fileUrl.toString();
        var strList=new Array();
        strList=url.split("/");
        var name=strList[strList.length-1];
        return name;
    }

    //标题栏区域
    Rectangle {
            id: mainTitle                       //创建标题栏
            anchors.top: parent.top             //对标题栏定位
            anchors.left: parent.left
            anchors.right: parent.right
            height: 25                          //设置标题栏高度
            color: "#7B7B7B"                    //设置标题栏背景颜色

            MouseArea { //为窗口添加鼠标事件
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton //只处理鼠标左键
                property point clickPos: "0,0"
                onPressed: { //接收鼠标按下事件
                        clickPos  = Qt.point(mouse.x,mouse.y)
                }
                onPositionChanged: { //鼠标按下后改变位置
                        //鼠标偏移量
                        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                        //如果mainwindow继承自QWidget,用setPos
                        myPlayer.setX(myPlayer.x+delta.x)
                        myPlayer.setY(myPlayer.y+delta.y)
                }
            }
            Row{
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                //窗口图片
                Image{
                    source: "qrc:/myPlayerIcon.ico"
                    sourceSize.width: 30
                    sourceSize.height: 25
                }
                //窗口标题
                Text{
                    anchors.top:parent.top
                    anchors.topMargin: 4
                    text: getVedioName(fd.fileUrl.toString()) ? "MyPlayer   Playing:" + getVedioName(fd.fileUrl.toString()) : "MyPlayer"
                    color:"white"
                    font.bold: true
                    font.pixelSize: 15
                }
            }
            Row{
                anchors.right: parent.right
                anchors.top:parent.top
                width:170
                height: 25

                //设置
                Button{
                    id:cfgButton
                    width: 50
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: cfgButtonTxt
                                text: qsTr("Config")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {
                        mainWinMask.visible = true;
                        //animationType: ["fade", "width", "height", "size", "flyDown", "flyUp", "flyLeft", "flyRight"]
                        cfgWin.animationType = "fade";
                        cfgWin.show();
                        console.log("myplaer x:" + myPlayer.x + " y:" + myPlayer.y)
                    }
                }

                //最小化
                Button{
                    id:minButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: minButtonTxt
                                text: qsTr("Min")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {
                          myPlayer.visibility = Window.Minimized
                    }
                }
                //最大化
                Button{
                    id:maxButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: maxButtonTxt
                                text: qsTr("Max")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {

                        if(isMaxStatus == 0){
                            myPlayer.visibility = Window.Maximized
                            isMaxStatus = 1;
                        }else{
                            myPlayer.visibility = Window.Windowed
                            isMaxStatus = 0;
                        }
                    }
                }
                //退出
                Button{
                    id:quitButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "red" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "red" : "#7B7B7B"
                            Text {
                                id: quitButtonTxt
                                text: qsTr("Quit")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {fd.close();  Qt.quit();}
                }
            }
    }
    //主窗体区域
    Column{
        anchors.top:parent.top
        anchors.topMargin: 25
        Rectangle{
            id:screen
            color:"black"
            width:myPlayer.width
            height: myPlayer.height-75

            MouseArea { //为窗口添加鼠标事件
                id: mouseRegion
                anchors.fill: parent;
                acceptedButtons: Qt.LeftButton | Qt.RightButton // 激活右键（别落下这个）

                onClicked: {
                    if (mouse.button === Qt.RightButton) { // 右键菜单
                                //
                        contentMenu.popup()
                     }else if(mouse.button === Qt.LeftButton){A
                        if (player.seekable)
                            playOrpauseButton.clicked();
                    }
                }
            }
            Menu { // 播放器右键菜单
                //title: "Edit"
                id: contentMenu

                MenuItem {
                    text: "Cut"
                    shortcut: "Ctrl+X"
                    onTriggered: {}
                }
            }
            //播放器初始背景图片
            Image{
                id:img
                source: ""
                anchors.fill: parent
            }
            MediaPlayer{
                id:player
                //source: fd.fileUrl
                source:"file:///D:/Qt/qml/video/dy.avi"
                autoPlay: true
                volume: voice.value
            }
            VideoOutput {
                anchors.fill: parent
                source: player
            }
        }
        Rectangle{
            id:control
            color:"#80202020"
            border.color: "gray"
            border.width: 1
            width:myPlayer.width
            height: 20
            Row{
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                anchors.left: parent.left
                //调节播放速度
                Slider{
                    id:playPos
                    width: myPlayer.width
                    height: 10
                    maximumValue: player.duration
                    minimumValue: 0
                    value:player.position
                    anchors.verticalCenter: parent.verticalCenter
                    stepSize:1000
                    style: SliderStyle {
                        groove: Rectangle {
                            width: myPlayer.width
                            height: 8
                            color: "white"
                            radius: 2
                            Rectangle {
                                id:sliderRect
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                //进度条进展
                                width: player.duration>0?parent.width*player.position/player.duration:0
                                color: "blue"
                            }
                        }
                        //进度条圆点浮标定制
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "yellow"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 15
                            implicitHeight: 15
                            radius:7.5
                            Rectangle{
                                width: parent.width-8
                                height: width
                                radius: width/2
                                color: "blue"
                                anchors.centerIn: parent
                            }
                        }
                    }
                    //点击鼠标设置播放位置
                    MouseArea {
                        property int pos
                        anchors.fill: parent
                        onClicked: {
                            if (player.seekable)
                                pos = player.duration * mouse.x/parent.width
                            player.seek(pos)
                        }
                    }
//                    onValueChanged: {
//                        var pos
//                        if (player.seekable)
//                            pos = player.position
//                        player.seek(pos)
//                        playPos.value=pos;
//                        playPos.value = player.position
//                        console.log("player.position:" + player.position + "playPos.value" + playPos.value)
//                    }
                }
                Image{
                    width: 15
                    height: 15
                    source: "./Images/voice.png"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        //控制区域
        Rectangle{
            id:bottom
            color:"#80202020"
            border.color: "gray"
            border.width: 1
            width: myPlayer.width
            height: 30
            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                spacing: 10
                Button{
                    id:playOrpauseButton
                    width: 60
                    height: 30
                    text: "Start"
                    property int status: 1  //默认播放
                    //iconSource: "./Images/pause.png"
                    onClicked: {
                        console.log(fd.fileUrl.toString())
                        if (player.seekable){
                            if(status===1)
                            {
                                player.pause();
                                tooltip="Start";
                                console.log("start")
                                playOrpauseButton.text = "Start"
                                status=0;
                                //iconSource="./Images/play.png"
                            }
                            else{
                                player.play() ;
                                tooltip="Pause";
                                console.log("pause")
                                playOrpauseButton.text = "Pause"
                                status=1;
                                //iconSource="./Images/pause.png"
                            }
                            var pos = player.position
                            player.seek(pos)
                        }
                    }
                }
                Button{
                    width: 60
                    height: 30
                    onClicked:
                    {
                        player.stop()
                        player.seek(0)
                        playOrpauseButton.status = 0
                        playOrpauseButton.text = "Start"
                    }
                    text:"Stop"
                    tooltip: "Stop"
                    //iconSource: "./Images/stop.png"
                }
                //快进快退10s
                Button{
                    width: 60
                    height: 30
                    text: "Back"
                    onClicked: {
                        if (player.seekable){
                        var pos = player.position-10000
                        player.seek(pos)
                        }
                    }
                    tooltip: "Back"
                    //iconSource: "./Images/back.png"
                }
                Button{
                    width: 60
                    height: 30
                    text: "Forward"
                    onClicked: {
                        if (player.seekable){
                        var pos = player.position+10000
                        player.seek(pos)
                        }
                    }
                    tooltip: "Forward"
                    //iconSource: "./Images/pass.png"
                }
                Button{
                    width: 60
                    height: 30
                    tooltip: "Open"
                    text: "Open"
                    onClicked: fd.open()
                    //iconSource: "./Images/add.png"
                    FileDialog{
                        id:fd
                        //fileUrl:"file:///D:/Qt/qml/dy.avi"
                        nameFilters: ["Vedio Files(*.avi *.mp4 *rmvb *.rm)"]  //格式过滤
                        selectMultiple: false
                    }
                }
            }
            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                spacing: 10
                Text{
                    id:movieTimeText
                    anchors.verticalCenter: parent.verticalCenter
                    text:parent.currentTime(player.position)+"/"+parent.currentTime(player.duration)
                    color: "white"
                }
                //调节音量
                Slider{
                    id:voice
                    width: myPlayer.width*0.2
                    height: 10
                    value:0.5
                    stepSize: 0.01
                    maximumValue: 1
                    minimumValue: 0
                    anchors.verticalCenter: parent.verticalCenter
                    style: SliderStyle {
                        groove: Rectangle {
                            implicitWidth: myPlayer.width*0.2
                            implicitHeight: 8
                            color: "white"
                            radius: 2
                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                width: player.volume>0?parent.width*player.volume:0
                                color: "blue"
                            }
                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "darkgray"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 15
                            implicitHeight: 15
                            radius:7.5
                            Rectangle{
                                width: parent.width-8
                                height: width
                                radius: width/2
                                color: "blue"
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
                //时间格式化
                function currentTime(time)
                {
                    var sec= Math.floor(time/1000);
                    var hours=Math.floor(sec/3600);
                    var minutes=Math.floor((sec-hours*3600)/60);
                    var seconds=sec-hours*3600-minutes*60;
                    var hh,mm,ss;
                    if(hours.toString().length<2)
                        hh="0"+hours.toString();
                    else
                        hh=hours.toString();
                    if(minutes.toString().length<2)
                        mm="0"+minutes.toString();
                    else
                        mm=minutes.toString();
                    if(seconds.toString().length<2)
                        ss="0"+seconds.toString();
                    else
                        ss=seconds.toString();
                    return hh+":"+mm+":"+ss
                }
            }
        }
    }
}




