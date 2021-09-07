import 'package:appuninstaller/models/usagedata.dart';
import 'package:appuninstaller/screens/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ActiveGamesItem extends StatelessWidget {
  ActiveGamesItem(
      {this.name = 'No name', this.status = 'In progress', this.icon , this.usageData});

  final IconData icon;
  final String name;
  final String status;
  final UsageData usageData;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(5), topRight: Radius.circular(5));
    var deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 80,
          width: deviceSize.width,
          decoration: BoxDecoration(
            color: Color(0xFF2E123A),
            borderRadius: radius,
          ),
          padding: const EdgeInsets.only(top: 7),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                  backgroundColor: Color(0xFFD46286),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PTSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Status - $status',
                  style: TextStyle(
                      color: Colors.white54,
                      fontFamily: 'PTSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
        Container(
          width: deviceSize.width,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5)),
            gradient: LinearGradient(
                colors: [
                  Color(0xFFD46286),
                  Color(0xFF781C50),
                ],
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: new FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {
              print(usageData.keyval);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new Leaderboard(usageData)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View leaderboard',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PTSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    LineIcons.level_up,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
