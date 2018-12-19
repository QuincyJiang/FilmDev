library splashscreen;
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Widget title;
  final Widget description;
  final Color backgroundColor;
  final dynamic navigateAfterSeconds;
  final double photoWidth;
  final double photoHeight;
  final dynamic onClick;
  final Widget image;
  SplashScreen(
      {
        @required this.seconds,
        this.photoWidth,
        this.onClick,
        this.navigateAfterSeconds,
        this.title = const Text('Welcome In Our App'),
        this.backgroundColor = Colors.white,
        this.image,
        this.photoHeight,
        this.description
      }
      );


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   startTimer(widget, context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 200, 0.0, 0.0),
          ),
        Container(
              height: widget.photoHeight,
              width: widget.photoWidth,
              child: widget.image,
              constraints:  BoxConstraints.expand(height: widget.photoHeight),
              padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 250, 0.0, 0.0),
          ),
            widget.title,
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
          ),
          widget.description
        ],
      ),
    );
  }
}



void startTimer(SplashScreen widget,BuildContext context){
  Timer(
      Duration(seconds: widget.seconds),
          () {
        if (widget.navigateAfterSeconds is String) {
          // It's fairly safe to assume this is using the in-built material
          // named route component
          return Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
        } else if (widget.navigateAfterSeconds is Widget) {
          return Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));
        } else {
          throw new ArgumentError(
              'widget.navigateAfterSeconds must either be a String or Widget'
          );
        }
      }
  );
}
