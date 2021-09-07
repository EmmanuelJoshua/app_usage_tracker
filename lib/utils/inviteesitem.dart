import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class InviteesItem extends StatefulWidget {
  InviteesItem({this.name});

  final String name;

  @override
  _InviteesItemState createState() => _InviteesItemState();
}

class _InviteesItemState extends State<InviteesItem> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(5), topRight: Radius.circular(5));
    var deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 75,
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
                  LineIcons.user,
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
            ),
          ]),
        ),
      ],
    );
  }
}
