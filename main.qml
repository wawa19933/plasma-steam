import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.2
import "steamApi.js" as SteamAPI

Window {
    visible: true
    width: 310
    height: 400
    title: qsTr("Hello World")

    Component.onCompleted: {
        SteamAPI.apiKey = "6918C30A04EE430F03C44F66E0E4D704";
        SteamAPI.ownId = "76561198062615737";
    }

//    XmlListModel {
//        id: xmlModel
//        source: apiUrl + "GetFriendList/v0001/?key="+apiKey+"steamid=76561198062615737&relationship=friend&format=xml"
//        query: "/friendslist/friends//steamid/text()"
//    }

    ListModel {
        id: listModel
//        onDataChanged: console.log(name, 'added')
    }

    MainForm {
        anchors.fill: parent
        model: listModel
//        listView.model: listModel

        Component.onCompleted: {
            SteamAPI.updateFriends(listModel)
        }
    }
}
