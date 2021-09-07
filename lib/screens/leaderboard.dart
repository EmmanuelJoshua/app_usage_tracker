import 'package:appuninstaller/models/usagedata.dart';
import 'package:appuninstaller/theme.dart';
import 'package:appuninstaller/utils/radiantgradientmask.dart';
import 'package:appuninstaller/widgets/leaderboarditem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard(this.usageData);
  final UsageData usageData;
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List userid = [];
  List time = [];
  List name = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: RadiantGradientMask(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  LineIcons.long_arrow_left,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            'Leaderboard',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PTSans',
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF2B1137)),
      backgroundColor: primaryColor,
      body: Container(
          child: FutureBuilder(
              future: FirebaseDatabase.instance
                  .reference()
                  .child('Games')
                  .child(widget.usageData.key)
                  .child('Players')
                  // .orderByChild('Players')
                  // .equalTo(arguments['id'])
                  .once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  userid.clear();
                  time.clear();
                  name.clear();
                  List<dynamic> map = snapshot.data.value;
                  map.forEach((values) {
                    userid.add(values['Userid']);
                    time.add(values['Total time']);
                    name.add(values['Name']);
                  });

                  return ListView.builder(
                    itemCount: map.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return LeaderboardItem(
                        name: name[index],
                        time: time[index] == null? 0 : time[index],
                      );
                    },
                    padding:
                        const EdgeInsets.only(top: 15, left: 12, right: 12),
                  );
                } else {
                  return Center(
                    child: Lottie.asset('assets/images/loading.json',
                        height: deviceSize.height / 1.5,
                        width: deviceSize.width / 1.5),
                  );
                }
              })),
    );
  }
}
