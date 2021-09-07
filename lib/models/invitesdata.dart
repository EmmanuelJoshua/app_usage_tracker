import 'package:firebase_database/firebase_database.dart';

class InvitesData{
  String key;
  String username;
  String inviteStatus;
  String userId;
  List invitees;
  String url;

  InvitesData(this.username, this.userId,this.inviteStatus,this.url,{this.key,this.invitees});

  String get userName => username;
  String get status => inviteStatus;
  String get userid => userId;
  String get keyval => key;
  List get invites => invitees;
  String get urlVal => url;

  InvitesData.fromSnapShot(DataSnapshot snapshot){
    key = snapshot.key;
    username = snapshot.value['userName'];
    inviteStatus = snapshot.value['status'];
    userId = snapshot.value['userid'];
    key = snapshot.value['keyval'];
    invitees = snapshot.value['invites'];
    url = snapshot.value['urlVal'];
  }

}