import 'package:appuninstaller/utils/radiantgradientmask.dart';
import 'package:appuninstaller/widgets/drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:appuninstaller/screens/activegames.dart';
import 'package:appuninstaller/utils/customslideup.dart';
import 'package:appuninstaller/theme.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Games extends StatefulWidget {
  static const String routeName = '/games';

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  GlobalKey globalKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(10));

  String id;
  List games = [];
  String now;
  Query query;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('userid');
    });
    now = dateFormat.format(DateTime.now());
    query = FirebaseDatabase.instance
        .reference()
        .child('Games')
        .orderByKey()
        .startAt(id)
        .endAt('$id\uf8ff');

    // await FirebaseDatabase.instance.reference().child("Games").orderByChild('From').once().then((DataSnapshot snapshot) {
    // });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Games',
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
        backgroundColor: primaryColor,
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                Container(
                  width: 12.0,
                  height: 40.0,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 1.5,
                    width: 19,
                    color: Color(0xFFD1D1D3),
                  ),
                ),
                Text('Host a game',
                    style: TextStyle(
                        fontFamily: 'PTSans',
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Wrap(
                children: [
                  Text(
                      'Create a game where you can select an app which you want to minimize the usage. ',
                      style: TextStyle(
                          fontFamily: 'PTSans',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: radius,
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
                    Navigator.of(context).push(CustomSlideUp());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create game',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PTSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          LineIcons.plus_circle,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )),
//            ),
            Container(
                margin: const EdgeInsets.only(top: 15),
                color: Color(0xFF2B1137),
                height: 140,
                child: FutureBuilder(
                    future: query.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      Widget mainWidget;
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.value != null) {
                          Map<dynamic, dynamic> map = snapshot.data.value;
                          map.forEach((key, values) {
                            games.add(values['App Name']);
                            print('the games: $values');
                          });

                          mainWidget = Center(
                            child: ListView.builder(
                              itemCount: games.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)
                                        ),
                                        color: Color(0xFFAFAFA),
                                      ),
                                      height: 80,
                                      width: 97,
                                      margin: const EdgeInsets.only(
                                          top: 15, left: 8, right: 8),
                                      child: Center(
                                        child: CircleAvatar(
                                          child: Icon(
                                            LineIcons.gamepad,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: Color(0xFFD46286),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 97,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                        ),
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          games[index],
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'PTSans',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          mainWidget = Center(
                            child: Lottie.asset('assets/images/loading.json',
                                height: 80),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        mainWidget = Lottie.asset(
                          'assets/images/wifi.json',
                        );
                      }
                      return mainWidget;
                    })),
            Row(
              children: [
                Container(
                  width: 12.0,
                  height: 40.0,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 1.5,
                    width: 19,
                    color: Color(0xFFD1D1D3),
                  ),
                ),
                Text('View game progress',
                    style: TextStyle(
                        fontFamily: 'PTSans',
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 10),
              child: Wrap(
                children: [
                  Text('View the progress of all your active games. ',
                      style: TextStyle(
                          fontFamily: 'PTSans',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
              decoration: BoxDecoration(
                borderRadius: radius,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new ActiveGames()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View all games',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PTSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        LineIcons.long_arrow_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
