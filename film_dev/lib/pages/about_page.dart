import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SafeArea(
                top: false,
                bottom: false,
                child: Card(
                    elevation: 1,
                    margin: const EdgeInsets.fromLTRB(24,20,24.0,10),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        topRight: Radius.circular(2.0),
                        bottomLeft: Radius.circular(2.0),
                        bottomRight: Radius.circular(2.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: new FlareActor("assets/title.flr",
                              alignment:Alignment.center,
                              fit:BoxFit.contain,
                              animation:"enter"),
                          constraints:  BoxConstraints.expand(height: 150),
                        ),
                        Center(
                          child: Padding(padding:EdgeInsets.all(10),
                            child: Text("关于本应用 \n ",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                          ),
                            textAlign: TextAlign.center,),
                          ),
                        ),
                        Center(
                          child: Padding(padding:EdgeInsets.all(20),
                            child: Text("这是一款给喜欢手工黑白暗房技术的朋友提供的冲洗数据库小工具。\n\n"
                                "使用了FLutter的跨平台开发方案，所有交互动画均使用https://www.2dimensions.com/的flare工具制作。\n\n"
                                "数据抓取自 https://www.digitaltruth.com/ \n"
                                "仅限个人交流和使用，严谨用于商业用途。\n",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                              ),
                              textAlign: TextAlign.left,),
                          ),
                        ),
                      ],))))
    );
  }
}
