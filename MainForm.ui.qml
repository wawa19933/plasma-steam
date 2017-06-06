import QtQuick 2.7

Rectangle {

    width: 360
    height: 360
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#383535"
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
        anchors.fill: parent
        spacing: 5
        section.property: "status"
        section.delegate: Item {
            height: 10
            width: listView.width
            Rectangle {
                anchors.fill: parent
                color: '#90383535'

                Text {
                    text: section
                    anchors.fill: parent
                    font.pixelSize: 10
                    color: 'white'
                }
            }
        }

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
                        text: nick + ' - ' + name
                        font.bold: true
                        color: 'white'
                    }

                    Text {
                        text: status + ' ' + game
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
