import QtQuick 2.7

Rectangle {

    width: 360
    height: 360
    color: "#e6161616"
    property alias listView: listView
    property alias model: listView.model

    ListView {
        id: listView
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        flickDeceleration: 800
        maximumFlickVelocity: 2500
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
        anchors.fill: parent
        spacing: 15

        delegate: Item {
            x: 5
            width: listView.width
            height: 40
            Row {
                id: row1
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    width: 40
                    height: 40
                    border.width: 2
                    border.color: scolor
                    Image {
                        anchors.rightMargin: 2
                        anchors.leftMargin: 2
                        anchors.bottomMargin: 2
                        anchors.topMargin: 2
                        fillMode: Image.PreserveAspectCrop
                        anchors.fill: parent
                        sourceSize.height: 40
                        sourceSize.width: 40
                        source: photo
                    }
                }

                Column {
                    spacing: 1
                    Text {
                        text: nick
                        font.bold: true
                        color: scolor
                    }

                    Text {
                        text: status
                        color: scolor
                        font.weight: Font.Light
                        font.italic: true
                        verticalAlignment: Text.AlignTop
                    }
                }
            }
        }
    }
}
