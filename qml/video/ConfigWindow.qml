

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Window 2.1
import QtQuick.Controls.Styles 1.1


Window {
    id: root
    color: 'lightblue'

    // 公有属性
    property bool showMask : false;
    property string animationType : 'none';
    property int duration : 500
    property int easingType : Easing.OutBounce


    // 私有属性
    property int innerX;
    property int innerY;
    property int innerWidth;
    property int innerHeight;
    property double innerOpacity;


    //------------------------------
    // 事件
    //------------------------------
    // 属性备份一下，避免动画对属性进行变更
    Component.onCompleted: {
        console.log("save config window data")
        save();
    }

    function show()
    {
        console.log("now show popup");
        console.log("show cfgWin x:" + root.x + " y:" + root.y)
        reset();
        switch (animationType)
        {
            case "fade":     animFadeIn.start(); break;
            case "width":    animWidthIncrease.start(); break;
            case "height":   animHeightIncrease.start(); break;
            case "size":     animBig.start(); break;
            case "flyDown":  animInDown.start(); break;
            case "flyUp":    animInUp.start(); break;
            case "flyLeft":  animInLeft.start(); break;
            case "flyRight": animInRight.start(); break;
            default:         this.visible = true;
        }
    }

    function hide()
    {
        switch (animationType)
        {
            case "fade":    connector.target = animFadeOut;        animFadeOut.start(); break;
            case "width":   connector.target = animWidthDecrease;  animWidthDecrease.start();   break;
            case "height":  connector.target = animHeightDecrease; animHeightDecrease.start();  break;
            case "size":    connector.target = animSmall;          animSmall.start();   break;
            case "flyDown": connector.target = animOutUp;          animOutUp.start();   break;
            case "flyUp":   connector.target = animOutDown;        animOutDown.start(); break;
            case "flyLeft": connector.target = animOutRight;       animOutRight.start();break;
            case "flyRight":connector.target = animOutLeft;        animOutLeft.start(); break;
            default:        close();
        }
    }

    // 动画结束后调用的脚本
    Connections{
        id: connector
        target: animInDown
        onStopped: close()
    }



    //------------------------------
    // 辅助方法
    //------------------------------
//    function getRoot(item)
//    {
//        return (item.parent !== null) ? getRoot(item.parent) : item;
//    }

    function save()
    {
        console.log("save cfgWin x:" + root.x + " y:" + root.y)
        //innerX = root.x;
        //innerY = root.y;
        innerWidth = root.width;
        innerHeight = root.height;
        innerOpacity = root.opacity;
        console.log("save x=" + innerX + " y="+innerY + " w=" + innerWidth + " h="+innerHeight);
    }

    function reset()
    {
        //root.x = innerX;
        //root.y = innerY;
        root.width = innerWidth
        root.height = innerHeight;
        root.opacity = innerOpacity;
        //root.scale = 1;

        connector.target = null;
        //mask.visible = showMask;
        root.visible = true;
    }

    // 立即关闭
    function close()
    {
        mainWinMask.visible = false;
        root.visible = false;
        log();
    }

    function log()
    {
        console.log("x=" + x + " y="+y + " w=" + width + " h="+height);
    }




    //------------------------------
    // 遮罩
    //------------------------------
//    // 禁止事件穿透
//    MouseArea{
//        anchors.fill: parent;
//        onPressed:{
//             mouse.accepted = true
//        }
//        //drag.target: root  // root可拖动
//    }

    // 灯箱遮罩层
//    Mask{
//        id: mask
//        visible: false
//    }





    //------------------------------
    // 动画
    //------------------------------
    // fadeIn/fadeOut
    PropertyAnimation {
        id:animFadeIn
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'opacity';
        from: 0;
        to: root.innerOpacity
    }
    PropertyAnimation {
        id: animFadeOut
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'opacity';
        from: root.innerOpacity;
        to: 0
    }

    // width
    PropertyAnimation {
        id: animWidthIncrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'width';
        from: 0;
        to: root.innerWidth
    }
    PropertyAnimation {
        id: animWidthDecrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'width';
        from: root.innerWidth;
        to: 0
    }

    // height
    PropertyAnimation {
        id: animHeightIncrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'height';
        from: 0;
        to: root.innerHeight
    }
    PropertyAnimation {
        id: animHeightDecrease
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'height';
        from: root.innerHeight;
        to: 0
    }


    // size（如何控制size动画的中心点）
    PropertyAnimation {
        id: animBig
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'scale';
        from: 0;
        to: 1
    }
    PropertyAnimation {
        id: animSmall
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'scale';
        from: 1;
        to: 0
    }

    // fly in
    PropertyAnimation {
        id: animInRight
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: -root.innerWidth;
        to: root.innerX
    }
    PropertyAnimation {
        id: animInLeft
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: root.width;
        to: root.innerX
    }
    PropertyAnimation {
        id: animInUp
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: root.height;
        to: root.innerY
    }
    PropertyAnimation {
        id: animInDown
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: -root.innerHeight
        to: root.innerY
    }


    // fly out
    PropertyAnimation {
        id: animOutRight
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: root.innerX;
        to: root.width
    }
    PropertyAnimation {
        id: animOutLeft
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'x';
        from: root.innerX;
        to: -root.width
    }
    PropertyAnimation {
        id: animOutUp
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: root.innerY;
        to: -root.height
    }
    PropertyAnimation {
        id: animOutDown
        target: root
        duration: root.duration
        easing.type: root.easingType
        property: 'y';
        from: root.innerY
        to: root.height
    }

    flags: Qt.Window | Qt.FramelessWindowHint
    //标题栏区域
    Rectangle {
            id: cfgWindowTitle                       //创建标题栏
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
                        mouse.accepted = true
                }
                onPositionChanged: { //鼠标按下后改变位置
                        //鼠标偏移量
                        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                        //如果窗体继承自QWidget,用setPos
                        root.setX(root.x+delta.x)
                        root.setY(root.y+delta.y)
                }
            }
            //窗口标题
            Text{
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top:parent.top
                anchors.topMargin: 6
                text: "Config"
                color:"white"
                font.bold: true
                font.pixelSize: 15
            }
            Row{
                anchors.right: parent.right
                anchors.top:parent.top
                width:60
                height: 25

                //退出
                Button{
                    id:quitButton
                    width: 60
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
                    onClicked: {hide();}
                }
            }
    }
}
