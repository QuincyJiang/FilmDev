import 'dart:async';
import 'package:flutter/material.dart';

class SplashWidget2 extends StatefulWidget {
  final dynamic navigateAfterSeconds;
  final int seconds;
  final Widget title;
  final Widget description;

  SplashWidget2(
      {@required this.seconds,
      this.navigateAfterSeconds,
      this.description,
      this.title});

  @override
  _SplashWidget2State createState() => _SplashWidget2State();
}

class _SplashWidget2State extends State<SplashWidget2> {
  @override
  void initState() {
    /* TODO: implement initState*/ super.initState();
    startTimer(widget, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ConstrainedBox(
          child: Image.asset(
            "assets/splash2.jpg",
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(),
        ),
    ConstrainedBox(
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          widget.title,
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          ),
          widget.description,
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          ),
        ],
      ),
    ),

            ],
          ),
    );
  }
}

void startTimer(SplashWidget2 widget, BuildContext context) {
  Timer(Duration(seconds: widget.seconds), () {
    if (widget.navigateAfterSeconds is String) {
      return Navigator.of(context)
          .pushReplacementNamed(widget.navigateAfterSeconds);
    } else if (widget.navigateAfterSeconds is Widget) {
      return Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => widget.navigateAfterSeconds));
    } else {
      throw new ArgumentError(
          'widget.navigateAfterSeconds must either be a String or Widget');
    }
  });
}

class LogoFade extends StatefulWidget {
  @override
  createState() => new LogoFadeState();
}

class LogoFadeState extends State<LogoFade> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    /* TODO: implement initState*/ super.initState();
    setState(() {
      opacityLevel = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedOpacity(
      duration: new Duration(seconds: 3),
      child: new FlutterLogo(
        size: 100.0,
      ),
      opacity: opacityLevel,
      curve: Curves.linear,
    );
  }
}
