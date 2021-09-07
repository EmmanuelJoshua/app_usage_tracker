import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String deviceName;
  String identifier;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

    print(deviceName);
    print(identifier);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Device name : $deviceName\n ID : $identifier',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
