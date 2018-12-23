import 'package:film_dev/model/dev_detail.dart';
import 'package:flutter/material.dart';

class DevPage extends StatefulWidget {
  final DevDetails details;

  DevPage(this.details);

  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("DevPage"),
    );
  }
}
