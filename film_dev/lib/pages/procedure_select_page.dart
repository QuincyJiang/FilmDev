import 'package:film_dev/utils/device_util.dart';
import 'package:film_dev/widgets/intro_page_view.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProcedureSelectPage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ProcedureSelectPage> {
  @override
  void initState() {
    super.initState();
    DeviceUtil.instance.enterFullScreen();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: IntroPageView(),
        onWillPop: (){
          return showDeleteConfigDialog(context);
        }
    );
  }
  Future<bool> showDeleteConfigDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('要退出吗？'),
          actions: <Widget>[
            FlatButton(
                child: const Text('取消'),
                onPressed: () { Navigator.pop(context); }
            ),
            FlatButton(
                child: const Text('确认'),
                onPressed: () {
                  exit(0);
                  Navigator.pop(context);
                }
            )
          ]
      ),
    );
  }
}

