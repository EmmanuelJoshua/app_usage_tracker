import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LeaderboardItem extends StatefulWidget {
  LeaderboardItem({this.name, this.time});

  final String name;
  final double time;

  @override
  _LeaderboardItemState createState() => _LeaderboardItemState();
}

class _LeaderboardItemState extends State<LeaderboardItem> {
  String makeTime(time) {
    String result = '';
    String timeInMins;
    timeInMins = (time / 60).toStringAsFixed(2);
    if (time / 60 < 1.0) {
      result += '$time seconds';
    }
    if (time / 60 > 1.0 && time / 60 < 60.0) {
      result += '$timeInMins minutes';
    }
    if (time / 60 > 60.0) {
      timeInMins = (time / 3600).toStringAsFixed(2);
      result += '$timeInMins hours';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(5), topRight: Radius.circular(5));
    var deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 79,
          width: deviceSize.width,
          decoration: BoxDecoration(
            color: Color(0xFF2E123A),
            borderRadius: radius,
          ),
          padding: const EdgeInsets.only(top: 7),
          child: Column(children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  LineIcons.star,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFFD46286),
              ),
              title: Text(
                widget.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PTSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Time - ${makeTime(widget.time)}',
                style: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'PTSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ]),
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rank - ',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PTSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    LineIcons.star_o,
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
