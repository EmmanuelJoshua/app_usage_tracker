import 'package:firebase_database/firebase_database.dart';

class UsageData {
  String key;
  String appname;
  double time;
  String gameid;
  String type;
  String userid;
  String gamefrom;
  String gameto;
  String packagename;
  String name;

  UsageData(this.appname, this.time, this.gameid, this.type, this.userid,
      this.gamefrom, this.gameto,this.packagename,this.name,{this.key});

  String get appName => appname;
  String get keyval => key;
  double get totalTime => time;
  String get gameId => gameid;
  String get usagetype => type;
  String get userId => userid;
  String get gameFrom => gamefrom;
  String get gameTo => gameto;
  String get packageName => packagename;
  String get playerName => name;

  UsageData.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;
    appname = snapshot.value['appName'];
    time = snapshot.value['totalTime'];
    gameid = snapshot.value['gameId'];
    type = snapshot.value['usageType'];
    userid = snapshot.value['userId'];
    gamefrom = snapshot.value['gameFrom'];
    gameto = snapshot.value['gameTo'];
    packagename = snapshot.value['packageName'];
    name = snapshot.value['playerName'];
  }
}
