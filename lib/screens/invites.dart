import 'package:appuninstaller/screens/recievedinvites.dart';
import 'package:appuninstaller/screens/sentinvites.dart';
import 'package:appuninstaller/theme.dart';
import 'package:appuninstaller/utils/radiantgradientmask.dart';
import 'package:appuninstaller/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Invites extends StatefulWidget {
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<Invites>
    with SingleTickerProviderStateMixin<Invites> {
  int selectedIndex = 1;

  final iconList = [
    TabItemIcon(
        iconData: LineIcons.arrow_circle_o_up,
        startColor: Color(0xFF270F33),
        curveColor: Color(0xFF270F33)),
    TabItemIcon(
        iconData: LineIcons.arrow_circle_o_down,
        startColor: Color(0xFF270F33),
        curveColor: Color(0xFF270F33)),
  ];

  void onChangeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  GlobalKey globalKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static List<String> screenNames = <String>[
    'Sent Invites',
    'Received Invites',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: iconList.length,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: RadiantGradientMask(
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    icon: Icon(
                      LineIcons.bars,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(
                screenNames[selectedIndex - 1],
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PTSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: RadiantGradientMask(
                    child: IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
              elevation: 0,
              backgroundColor: Color(0xFF2B1137)),
          drawer: AppDrawer(),
          bottomNavigationBar: JumpingTabBar(
            onChangeTab: onChangeTab,
            duration: Duration(milliseconds: 1000),
            circleGradient: LinearGradient(
                colors: [
                  Color(0xFFD46286),
                  Color(0xFF781C50),
                ],
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            items: iconList,
            selectedIndex: selectedIndex,
          ),
          backgroundColor: Colors.white,
          body: Container(
            color: primaryColor,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [SentInvites(), RecievedInvites()],
            ),
          ),
        ));
  }
}
