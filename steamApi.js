.pragma library
var apiUrl = "http://api.steampowered.com/"
var apiKey = "";
var ownId = "";

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


var req = new XMLHttpRequest;
var friendsModel;

function updateFriends(model) {
    friendsModel = model;
    getFriendsId(ownId)
}


function getFriendsId(userId) {
    var method = "ISteamUser/GetFriendList/v0001/?key=" + apiKey + "&";
    var url = apiUrl + method + "steamid=" + userId + "&relationship=friend&format=json";
    req.open("GET", url, false);
    req.onreadystatechange = function () {
        if (req.readyState == req.DONE) {
            var friends = JSON.parse(req.responseText).friendslist.friends;
            if (!friends) {
                console.log(req.responseText);
            }
            var ids = "";
            for (var i in friends) {
                ids += ',' + friends[i].steamid;
            }
            getProfiles(ids);
        }
    }
    req.send();
}


function getProfiles(steamIds) {
    var method = "ISteamUser/GetPlayerSummaries/v0002/?key=" + apiKey + "&";
    var url = apiUrl + method + "steamids=" + steamIds;
    req.open("GET", url, false);
    req.onreadystatechange = function () {
        if (req.readyState == req.DONE) {
            var players = JSON.parse(req.responseText).response.players;
            friendsModel.clear();
            var count = {
                "online": 0,
//                "busy": 0,
//                "away": 0,
//                "snooze": 0,
//                "trade": 0,
                "play": 0
            }

            for (var i in players) {
                if (players[i].communityvisibilitystate < 3)
                    continue;

                var obj = {
                    "steamid": players[i].steamid,
                    "nick": players[i].personaname,
                    "scolor": "#969696",
                    "status": userStatus[players[i].personastate],
//                    "gameid": players[i].gameid,
//                    "game": players[i].gameextrainfo,
//                    "visibility": userVisibility[players[i].communityvisibilitystate],
                    "photo": players[i].avatarmedium
                };

                switch(players[i].personastate) {
                case 1: // Online
                    if (players[i].gameextrainfo) {
                        obj.status = "In " + players[i].gameextrainfo;
                        obj.scolor = "#b4e62a";
                        friendsModel.insert(0, obj);
                    }
                    else {
                        obj.scolor = "#379ddc"
                        friendsModel.insert(count.online, obj);
                    }
                    for (var j in count)
                        count[j]++;
                    break;
                case 6: // Looking to play
                    friendsModel.insert(count.play);
                    count.play++;
                    break;
                case 0:
                    obj.status = timeSince(players[i].lastlogoff * 1000)
                default:
                    friendsModel.append(obj);
                }
            }
        }
    }
    req.send();
}


var timeSince = function(date) {
  if (typeof date !== 'object') {
    date = new Date(date);
  }

  var seconds = Math.floor((new Date() - date) / 1000);
  var intervalType;

  var interval = Math.floor(seconds / 31536000);
  if (interval >= 1) {
    intervalType = 'year';
  } else {
    interval = Math.floor(seconds / 2592000);
    if (interval >= 1) {
      intervalType = 'month';
    } else {
      interval = Math.floor(seconds / 86400);
      if (interval >= 1) {
        intervalType = 'day';
      } else {
        interval = Math.floor(seconds / 3600);
        if (interval >= 1) {
          intervalType = "hour";
        } else {
          interval = Math.floor(seconds / 60);
          if (interval >= 1) {
            intervalType = "minute";
          } else {
            interval = seconds;
            intervalType = "second";
          }
        }
      }
    }
  }

  if (interval > 1 || interval === 0) {
    intervalType += 's';
  }

  return interval + ' ' + intervalType + ' ago';
};
