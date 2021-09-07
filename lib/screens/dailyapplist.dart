import 'package:app_usage/app_usage.dart';
import 'package:appuninstaller/theme.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppList extends StatefulWidget {
  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  AppUsage appUsage = new AppUsage();
  Map<String, double> usage;
  String apps = 'Unknown';
  BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(10));

  @override
  void initState() {
    getUsageStats();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usage.clear();
  }

  Future<void> initPlatformState() async {}

  void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate =
          DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
      usage = await appUsage.fetchUsage(startDate, endDate);
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

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

  makeTimeDouble(time) {
    double result = 0;
    double timeInMins = (time / 60);
    result += (timeInMins / 1000);
    String res = result.toStringAsFixed(3);
    return double.parse(res);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                Text('Most used apps',
                    style: TextStyle(
                        fontFamily: 'PTSans',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))
              ],
            ),
            AnimatedContainer(
              width: deviceSize.width,
              height: deviceSize.height - 235,
              duration: Duration(milliseconds: 600),
              child: FutureBuilder(
                  future: DeviceApps.getInstalledApplications(
                      includeAppIcons: true),
                  builder: (context, data) {
                    if (data.data == null) {
                      return Center(
                        child: Lottie.asset('assets/images/loading.json',
                            height: deviceSize.height / 1.5,
                            width: deviceSize.width / 1.5),
                      );
                    } else {
                      List<Application> apps = data.data;
                      apps.sort((a, b) {
                        var one = usage.containsKey(a.packageName)
                            ? usage[a.packageName]
                            : 0;
                        var two = usage.containsKey(b.packageName)
                            ? usage[b.packageName]
                            : 0;
                        return two.compareTo(one);
                      });
                      return Scrollbar(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, position) {
                            Application app = apps[position];

                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: app is ApplicationWithIcon
                                      ? Image(
                                          image: MemoryImage(app.icon),
                                          height: 40,
                                          width: 40,
                                        )
                                      : null,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 9),
                                    child: Text(
                                      "${app.appName}",
                                      style: headlines,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          96,
                                      animation: true,
                                      backgroundColor: Color(0xFFAFAFA),
                                      lineHeight: 18.0,
                                      percent:
                                          usage.keys.contains(app.packageName)
                                              ? makeTimeDouble(
                                                  usage[app.packageName])
                                              : 0.0,
                                      center: Text(
                                        '${usage.keys.contains(app.packageName) ? makeTime(usage[app.packageName]) : 'No usage till now'}\n',
                                        style: leadlines,
                                      ),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      linearGradient: LinearGradient(

                                          colors: [
                                            Color(0xFFD46286),
                                            Color(0xFF781C50),
                                          ],
                                          tileMode: TileMode.mirror,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: apps.length,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}
