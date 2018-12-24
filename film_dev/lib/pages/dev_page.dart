import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/utils/device_util.dart';
import 'package:film_dev/widgets/count_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class DevPage extends StatefulWidget {
  final DevDetails details;
  String anim = "enter";
  bool isDarkMode = false;
  DevPage(this.details);
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String ANIM_ENTER = "enter";
  final String ANIM_FLICKER = "flicker";
  final String ANIM_DARKFLICKER = "darkFlicker";
  final String ANIM_ON = "on";
  final String ANIM_OFF = "off";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeviceUtil.instance.enterFullScreen();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DeviceUtil.instance.exitFullScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor:widget.isDarkMode? Colors.black:Colors.black,
        accentColor: widget.isDarkMode?Colors.red[900]:Colors.yellow[900],
        cardColor: widget.isDarkMode? Colors.black:Colors.grey[800],
        scaffoldBackgroundColor:widget.isDarkMode? Colors.black:Colors.grey[850],
        textTheme: TextTheme(
          subhead: TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
          subtitle:TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
          title:TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
          display1:TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
          display2:TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
          caption:TextStyle(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
          ),
        ), iconTheme: IconThemeData(
            color: widget.isDarkMode? Colors.grey[900]:Colors.white,
      )
      ),
      child: Scaffold(
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
                          child:
                         GestureDetector(
                        onTap: (){
                          processAnim();
                        },
                        child:  new FlareActor("assets/light.flr",
                            alignment:Alignment.center,
                            fit:BoxFit.contain,
                            animation:widget.anim),
                    ),
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
                                    color: widget.isDarkMode? Colors.grey[900]:Colors.white,
                                    fontSize: Theme.of(context).textTheme.subhead.fontSize
                                  ),
                                ),
                              ),
                            )
                        ),
                                buildTimerItem("显影A", "前一分钟持续搅拌，之后每分钟开始时搅拌5-10s", widget.details.devTimeA),
                                (widget.details.devTimeB == 0)?Container(height: 0,width: 0,):buildTimerItem("显影B", "点击开启计时，长按重置计时器", widget.details.devTimeB),
                                buildTimerItem("停显", "停显时间请参考您使用的停显液", 60),
                                buildTimerItem("定影", "定影时间请参考您使用的定影液", 300),
                                buildTimerItem("去海波", "防止片基出现水渍 并稳定您的底片", 120),
                                buildTimerItem("水洗", "使用流动清水持续冲洗", 600),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        ),
                      ],
                    )
                )
            )
        )));}

        void processAnim(){
         if(widget.isDarkMode){
           setState(() {
             widget.anim = ANIM_ON;
             widget.isDarkMode = false;
           });
         }else{
           setState(() {
             widget.anim = ANIM_OFF;
             widget.isDarkMode = true;
           });
         }
        }
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
          constraints: BoxConstraints(maxHeight: 1),
          decoration: BoxDecoration(color: widget.isDarkMode? Colors.black:Colors.grey[700]),
        ),
        Container(
            constraints: BoxConstraints.expand(height: 70),
            child: CountDownWidget(
              key: UniqueKey(),
              countDownSeconds: time,
              label: title,
    ),
    ),
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
