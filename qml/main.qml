import QtQuick 2.0
import QtQuick.Controls 1.1

Rectangle {
    id: page
    width: 800; height: 900
    //下面是渐变颜色
    gradient: Gradient {  
        GradientStop { position: 0.0; color: "#FFFFFF"; }  
        GradientStop { position: 0.5; color: "#0000ff"; }  
        GradientStop { position: 1.0; color: "#FFFFFF"; }  
    } 
    

Image {  
        id: imageViewer;  
        asynchronous: true;  
        cache: false;  
        anchors.fill: parent;  
        fillMode: Image.PreserveAspectFit;  
        onStatusChanged: {  
            if (imageViewer.status === Image.Loading) {  
                
               // stateLabel.visible = false;  
            }  
            else if(imageViewer.status === Image.Ready){  
                //busy.running = false;  
            }  
            else if(imageViewer.status === Image.Error){  
                //busy.running = false;  
                //stateLabel.visible = true;  
                //stateLabel.text = "ERROR";  
            }  
        }  
    }  
  
    Component.onCompleted: {  
        imageViewer.source = "http://img.9553.com/uploadfile/2016/0328/20160328090259881.jpg";  
    }  

    Button {
            width: 80; height: 50
            text: "通信";
            //anchors.centerIn: parent;
            onClicked: {
                console.log(">>>QML发声");
                //Qt.quit();
                //page.width+=20;
                con.outputString("Hello, Python3——"+page.width) 
            }
    }
    Button {
            anchors.right: parent.right
            width: 80; height: 50
            text: "退出";
            //anchors.centerIn: parent;
            onClicked: {
                console.log("\n退出\n");
                Qt.quit();
                //page.width+=20;
                //con.outputString("Hello, Python3——"+page.width) 
            }
    }
    Text {

        id: helloText
        text: "傻吊你好"
        //y: 30
        anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 10; font.bold: true

        MouseArea { id: mouseArea; anchors.fill: parent }

		// 为文本元素创建一个新的down状态
        states: State {
            name: "down"
            // 点击MouseArea时激活此状态，释放它将停用该状态
            when: mouseArea.pressed == true
            // 通过设置新的属性使文本状态改变
            PropertyChanges { target: helloText; y: 160; rotation: 180; color: "red" ;font.pointSize: 50;}
        }

		// 在两个状态之间的添加一个过渡(Transition)使得状态的切换更加平滑而美观
        transitions: Transition {
            from: ""; to: "down"
            // 设置逆转换时具有相同过渡效果
            reversible: true
            // ParallelAnimation使两种类型的动画（数字和颜色）同时开始,可以使用SequentialAnimation来逐个运行
            ParallelAnimation {
            	// 动画的过渡参数设置
                NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                ColorAnimation { duration: 500 }
            }
        }
    }

    Grid {
        id: colorPicker
        x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
        rows: 2; columns: 3; spacing: 3

        Cell { cellColor: "red"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
    }
}
