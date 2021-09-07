import 'package:appuninstaller/screens/homescreen.dart';
import 'package:appuninstaller/screens/invites.dart';
import 'package:appuninstaller/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//  bool isNotEmpty = false;
  check() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name');
    print(name);
    return name;
  }

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'App Usage Tracker',
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      routes: {
        // '/': (context) => MainScreen(),
        '/u9DC': (context) => Invites(),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: check(),
        builder: (context, data){
          if(data.data == null){
            return MainScreen();
          }else{
            return HomeScreen();
          }

        },
      )
    );
  }
  
 
  
}
