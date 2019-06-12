/*
import QtQuick 2.0
 
Rectangle {
    id: page
    width: 500; height: 200
    color: "lightgray"
 
    function updateRotater() {// 定义函数                             
        rotater.angle += 5
    }
 
    Rectangle {
        id: rotater
        property real angle : 0
        x: 240; y: 95
        width: 100; height: 5
        color: "black"
 
        transform: Rotation {
            origin.x: 10; origin.y: 5
            angle: rotater.angle
        }
    }
}
*/
import Charts 1.0
import QtQuick 2.0

Item {
    width: 300; height: 200

    PieChart {
        id: aPieChart
        anchors.centerIn: parent
        width: 100; height: 100
        color: "red"

        onChartCleared: console.log("The chart has been cleared") //槽
    }

    MouseArea {
        anchors.fill: parent
        onClicked: aPieChart.clearChart()
    }

    Text {
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 20 }
        text: "Click anywhere to clear the chart"
    }
}
