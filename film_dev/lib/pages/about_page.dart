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
                            child: Text("这是一款给喜欢手工冲洗黑白胶片的朋友提供的冲洗小工具。囊括了主流胶片的冲洗数据，希望可以帮到你。\n\n"
                                "App使用基于Flutter的跨平台开发技术，保证安卓和IOS有一致的体验，所有交互动画均使用2dimensions的flare工具制作。\n\n"
                                "\n\n反馈问题给我:"
                                "\nEmail:1083873272@qq.com"
                                "\nWechat: jxq19930625"
                                "\n\n 感谢："
                                "\n https://www.2dimensions.com/"
                                "\n https://www.digitaltruth.com/",
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
