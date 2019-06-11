import QtQuick 2.0

// Item是qml中最基本的可视元素，通常用于作为其他元素的容器
Item {
    id: container
    // cellColor属性可以从组件外部访问。它是组成单元格的矩形(rectangle)的现有颜色属性的别名
    property alias cellColor: rectangle.color
    // 定义了一个名为clicked的signal(信号)，用来改变文本的颜色
    signal clicked(color cellColor)
    width: 40; height: 25

	// 用于显示颜色的基础矩形
    Rectangle {
        id: rectangle
        border.color: "white"
        // 设置大小与父元素相同
        anchors.fill: parent
    }

	// MouseArea可以对鼠标事件做出反应，例如单击，悬停等
    MouseArea {
        anchors.fill: parent
        // 点击时触发cellColor的点击事件
        onClicked: container.clicked(container.cellColor)
    }
}
