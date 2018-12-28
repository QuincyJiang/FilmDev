import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/pages/film_select_page.dart';
import 'package:film_dev/utils/device_util.dart';
import 'package:film_dev/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
///
/// 闪屏页 在这里初始化数据库数据
///
class AppSplashPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<AppSplashPage> {
  @override
  void initState() {
    super.initState();
    DeviceUtil.instance.enterFullScreen();
    DbManager.instance.initDb();
  }
  @override
  Widget build(BuildContext context) {
    return new SplashWidget2(
      seconds: 3,
      navigateAfterSeconds: FilmSelectPage(),
      description: Container(),
      title: Container(
          decoration: new BoxDecoration(color: Colors.black),
          padding: EdgeInsets.all(2),
          child: new Text(' FilmDev',
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30.0),
          )
      ),);
  }
}
