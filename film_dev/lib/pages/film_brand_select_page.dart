import 'package:film_dev/utils/device_util.dart';
import 'package:flutter/material.dart';

class FilmBrandSelectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilmBrandState();
  }
}

class FilmBrandState extends State<FilmBrandSelectPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeviceUtil.instance.exitFullScreen();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: new Center(
          child: new Text(
              'FilmBrandSelectPage ',
              style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black)
          )
        )
    );
  }
}