import 'package:appuninstaller/screens/homescreen.dart';
import 'package:appuninstaller/utils/fadepageroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController name = TextEditingController();
  bool isEmpty = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  handleNameSubmit() async{
    if(name.text.isEmpty){
      setState(() {
        isEmpty = true;
      });
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
              content: new Text(
                  'Name field can\'t be empty',
                  style: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)
              ),
            backgroundColor: Color(0xFF15151F),
          )
      );
    }else{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('name', name.text);
      var router = FadePageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => HomeScreen());
      Navigator.of(context).pushReplacement(router);
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF15151F),
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Color(0xFF15151F),
              child: Image.asset('assets/images/1.jpg', height: 300,)
          ),
          Row(
            children: [
              Container(
                width: 12.0,
                height: 40.0,
                color: Colors.transparent,
              ),
              Text('De-',
                  style: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 42,
                      color: Color(0xFF2B1137),
                      fontWeight: FontWeight.w400))
            ],
          ),
          Row(
            children: [
              Container(
                width: 12.0,
                height: 40.0,
                color: Colors.transparent,
              ),
              Text('Addiction.',
                  style: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 48,
                      color: Color(0xFF2B1137),
                      fontWeight: FontWeight.w400))
            ],
          ),
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
              Text('Reduce app usage with the click of a button',
                  style: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 16,
                      color: Color(0xFF2B1137),
                      fontWeight: FontWeight.w400))
            ],
          ),
         Divider(),
          Container(
            height: 55,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 12),
            margin: const EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: isEmpty ? Border.all(color: Colors.red) : null,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFF1F1FD),
                      blurRadius: 15.0,
                      offset: Offset(0.3, 4.0))
                ],
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: TextFormField(
              controller: name,
              onChanged: (val){
                if(val.isNotEmpty){
                  setState(() {
                    isEmpty = false;
                  });
                }
              },
              style: TextStyle(
                  fontFamily: 'PTSans',
                  fontSize: 16,
                  color: Color(0xFF270F33),
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  focusColor: Color(0xFF2B1137),
                  fillColor: Color(0xFF2B1137),
                  hoverColor: Color(0xFF2B1137)),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
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
              onPressed: handleNameSubmit,
              child: Padding(
                padding: const EdgeInsets.only(left: 7, right: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Get started',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PTSans',
                          fontSize: 17,
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
      ),
    );
  }
}


