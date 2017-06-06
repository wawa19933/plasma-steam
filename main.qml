import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtQml.Models 2.2

Window {
    property string apiKey: "6918C30A04EE430F03C44F66E0E4D704"
    property string apiUrl: "http://api.steampowered.com/ISteamUser/"
    visible: true
    width: 310
    height: 400
    title: qsTr("Hello World")

    XmlListModel {
        id: xmlModel
        source: apiUrl + "GetFriendList/v0001/?key="+apiKey+"steamid=76561198062615737&relationship=friend&format=xml"
        query: "/friendslist/friends//steamid/text()"
    }

    ListModel {
        id: listModel
        onDataChanged: console.log(name, 'added')

    }

    MainForm {
        anchors.fill: parent
        model: listModel
//        listView.model: listModel
        function timeSince(date) {

          var seconds = Math.floor(((new Date().getTime()/1000) - date));

          var interval = Math.floor(seconds / 31536000);

          if (interval >= 1) {
            return interval + " years";
          }
          interval = Math.floor(seconds / 2592000);
          if (interval >= 1) {
            return interval + " months";
          }
          interval = Math.floor(seconds / 86400);
          if (interval >= 1) {
            return interval + " days";
          }
          interval = Math.floor(seconds / 3600);
          if (interval >= 1) {
            return interval + " hours";
          }
          interval = Math.floor(seconds / 60);
          if (interval >= 1) {
            return interval + " minutes";
          }
          return Math.floor(seconds) + " seconds";
        }

        function getFriends() {
            var method = 'GetFriendList/v0001/';
            var url = apiUrl + method + '?key=' + apiKey + '&steamid=76561198062615737&relationship=friend&format=json';
            var xhr = new XMLHttpRequest;
            var profileReq = new XMLHttpRequest;

            var userStatus = {
                "0": "Offline",
                "1": "Online",
                "2": "Busy",
                "3": "Away",
                "4": "Snooze",
                "5": "Looking to trade",
                "6": "Looking to play"
            };
            var userVisibility = {
                "1": "Private",
                "2": "Friends only",
                "3": "Friends of friends",
                "4": "Users",
                "5": "Public"
            };

            profileReq.onreadystatechange = function () {
                if (profileReq.readyState === XMLHttpRequest.DONE) {
                    var players = JSON.parse(profileReq.responseText).response.players;
                    listModel.clear();
                    for (var i in players) {
                        if (players[i].personastate === 0) {
                            console.log(timeSince(Date(players[i].lastlogoff)))
                        listModel.append({
                            "steamid": players[i].steamid,
                            "nick": players[i].personaname,
                            "name": players[i].realname,
                            "status": userStatus[players[i].personastate],
                            "gameid": players[i].gameid,
                            "game": players[i].gameextrainfo,
                            "visibility": userVisibility[players[i].communityvisibilitystate],
                            "photo": players[i].avatarmedium,
                        });
                        }
                    }
//                    listModel.sync();
                }
            }

            xhr.open("GET", url);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    var list = JSON.parse(xhr.responseText);
                    var friends = list.friendslist.friends;
                    var ids = "";
                    console.log("Friends count:", friends.length);
                    for (var i = 0; i < 20; i++) {
                        ids += "," + friends[i].steamid;
//                        var url = "http://steamcommunity.com/profiles/"+ friends[i].steamid +"/?xml=1";
//                        profileReq.open("GET", url);
//                        console.log('Received', friends[i].steamid)
                    }
                    method = "GetPlayerSummaries/v0002/";
                    url = apiUrl+method+"?key="+apiKey+"&steamids="+ids;
                    profileReq.open("GET", url, true);
                    profileReq.send();
                }
            }
            xhr.send();
        }
        Component.onCompleted: {
            getFriends();
        }
    }
}
