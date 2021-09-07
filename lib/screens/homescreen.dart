import 'dart:io';

import 'package:appuninstaller/screens/dailyapplist.dart';
import 'package:appuninstaller/screens/monthlyapplist.dart';
import 'package:appuninstaller/screens/weeklyapplist.dart';
import 'package:appuninstaller/theme.dart';
import 'package:appuninstaller/utils/radiantgradientmask.dart';
import 'package:appuninstaller/widgets/drawer.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jumping_bottom_nav_bar/jumping_bottom_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/appusage';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin<HomeScreen>, WidgetsBindingObserver {
  int selectedIndex = 1;

  final iconList = [
    TabItemIcon(
        iconData: LineIcons.clock_o,
        startColor: Color(0xFF270F33),
        curveColor: Color(0xFF270F33)),
    TabItemIcon(
        iconData: LineIcons.calendar_check_o,
        startColor: Color(0xFF270F33),
        curveColor: Color(0xFF270F33)),
    TabItemIcon(
        iconData: LineIcons.calendar,
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
    'Today',
    'Weekly',
    'Monthly',
  ];

  @override
  void initState() {
    //WidgetsBinding.instance.addObserver(this);
    super.initState();
    this.initDynamicLinks();
    getDeviceInfo();
  }

  void initDynamicLinks() async {
    String name;
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if(queryParams.length>0){
        name = queryParams['id'];
      }
      Navigator.pushNamed(context, deepLink.path 
     , arguments: {'id':name}
      );
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }
String id;
  getDeviceInfo() async{
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          id = build.androidId; //UUID for Android
        });
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userid', id);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        id = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }
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
            children: [AppList(), WeeklyList(), MonthlyList()],
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   WidgetsBinding.instance.removeObserver(this);
  // }
}
