import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/pages/film_brand_select_page.dart';
import 'package:film_dev/utils/device_util.dart';
import 'package:film_dev/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
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
    // TODO: implement initState
    super.initState();
    DeviceUtil.instance.enterFullScreen();
    DbManager.instance.initDb();
  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 10,
        navigateAfterSeconds: FilmBrandSelectPage(),
        title: new Text('FilmDev ',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new FlareActor("assets/demo.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"idle"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.red
    );
  }
}
