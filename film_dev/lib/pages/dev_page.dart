import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/widgets/count_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class DevPage extends StatefulWidget {
  final DevDetails details;

  DevPage(this.details);

  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String anim = "enter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child: SafeArea(
                top: false,
                bottom: false,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(24,0,24.0,10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: new FlareActor("assets/light.flr",
                              alignment:Alignment.center,
                              fit:BoxFit.contain,
//                              callback: (status){
//                                // 入场动画播放完毕后就开始播放跳动动画
//                                setState(() {
//                                  anim = "flicker";
//                                }
//                                );
//                              },
                              animation:anim),
                          constraints:  BoxConstraints.expand(height: 150),
                        ),
                        Card(
                            elevation: 1,
                            margin: EdgeInsets.fromLTRB(0,10,0,0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.0),
                                topRight: Radius.circular(2.0),
                                bottomLeft: Radius.circular(2.0),
                                bottomRight: Radius.circular(2.0),
                              ),
                            ),
                            child:Center(
                              child: Padding(padding:EdgeInsets.all(10),
                                child: Text("我的暗房",
                                  style: TextStyle(
                                      fontSize: Theme.of(context).textTheme.subhead.fontSize
                                  ),
                                ),
                              ),
                            )
                        ),
                                buildTimerItem("显影A", "前一分钟连续搅拌，后面 每一分钟的开始 搅拌5-10s", widget.details.devTimeA),
                                (widget.details.devTimeB == 0)?Container(height: 0,width: 0,):buildTimerItem("显影B", "点击开启计时，长按重置计时器", widget.details.devTimeB),
                                buildTimerItem("停显", "", 60),
                                buildTimerItem("定影", "", 300),
                                buildTimerItem("去海波", "", 120),
                                buildTimerItem("水洗", "", 600),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        ),
                      ],
                    )
                )
            )
        ));}
  
  Widget buildTimerItem(String title,String desp,int time){
    return Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(0,10,0,20),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(2.0),
    topRight: Radius.circular(2.0),
    bottomLeft: Radius.circular(2.0),
    bottomRight: Radius.circular(2.0),
    ),
    ),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        buildConfirmItem(title, desp, false),
        Container(
            constraints: BoxConstraints.expand(height: 70),
            child: CountDownWidget(
              countDownSeconds: time,
              label: title,
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.yellow[900],
              textColor: Colors.white,
    ),
    ),
    Container(
    constraints: BoxConstraints(maxHeight: 1),
    decoration: BoxDecoration(color: Colors.grey[700])),
        ]));
  }

  Widget buildConfirmItem(String title,String desc,bool showArrow){
    return MergeSemantics(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
          child: ListTile(
            dense: false,
            title: Text(title),
            subtitle: Text(desc),
            trailing: showArrow?Icon(Icons.arrow_right):Container(height: 0,width: 0,),
          ),
        )
    );
  }

}
