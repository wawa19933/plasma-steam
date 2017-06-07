import QtQuick 2.7

Rectangle {

    width: 360
    height: 360
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#524d4d"
        }

        GradientStop {
            position: 1
            color: "#1d1d1d"
        }
    }
    property alias listView: listView
    property alias model: listView.model

    ListView {
        id: listView
        flickDeceleration: 800
        maximumFlickVelocity: 2500
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
        anchors.fill: parent
        spacing: 5

        //        section.property: "status"
        //        section.delegate: Item {
        //            height: 15
        //            width: listView.width
        //            Rectangle {
        //                anchors.fill: parent
        //                color: "#b3272626"

        //                Text {
        //                    text: section
        //                    anchors.fill: parent
        //                    font.pixelSize: 10
        //                    color: 'white'
        //                }
        //            }
        //        }
        delegate: Item {
            x: 5
            width: listView.width
            height: 40
            Row {
                id: row1
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    width: 40
                    height: 40
                    sourceSize.height: 40
                    sourceSize.width: 40
                    source: photo
                }

                Column {
                    spacing: 5
                    Text {
                        text: nick
                        font.bold: true
                        color: "#222222"
                        function setColor() {}
                    }

                    Text {
                        text: status
                        color: 'lightgrey'
                        font.weight: Font.Light
                        font.italic: true
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}
