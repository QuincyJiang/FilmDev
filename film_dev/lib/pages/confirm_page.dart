
import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/pages/dev_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  final DevDetails details;
  ConfirmPage(this.details);
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}


class _ConfirmPageState extends State<ConfirmPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        child: new FlareActor("assets/list.flr",
            alignment:Alignment.center,
            fit:BoxFit.contain,
            callback: (status){
              // 入场动画播放完毕后就开始播放跳动动画
             setState(() {
               anim = "show";
             });
            },
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
          child: Text("确认配置清单",
                  style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subhead.fontSize
                  ),
                  ),
                ),
              )
            ),
      Card(
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
              child:buildLoadingResultView(widget.details)
          ),
        new Material(
            color: Colors.yellow[900],
            child: new InkWell(
              onTap: (){
                toDevPage(widget.details);
              },
            child: Center(
                  child: Padding(padding:EdgeInsets.all(10),
                    child: Text("开始冲洗",
                      style: TextStyle(
                          fontSize: Theme.of(context).textTheme.subhead.fontSize
                      ),
                    ),
                  ),
                )
            ),)
    ],
    )
    )
        )
    ));}

  // 展示查询结果
  Widget buildLoadingResultView(DevDetails details){
    return Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildConfirmIist(context,details));
  }

  List<Widget> buildConfirmIist(BuildContext context,DevDetails details){
      List<Widget> widgets = new List();
      widgets.add(buildConfirmItem(details, "胶片 ${details.medic.filmInfo.name}",details.medic.filmInfo.toString() ));
      widgets.add(buildConfirmItem(details, "药液", details.medic.toString()));
      widgets.add(buildConfirmItem(details, "迫冲","目标ISO: ${details.iso}"));
      widgets.add(buildConfirmItem(details, "冲洗温度","恒温（℃）：  ${details.temper}"));
      widgets.add(buildConfirmItem(details, "阶段A显影时长：","时长（秒）: ${details.devTimeA}"));
      widgets.add(buildConfirmItem(details, "阶段B显影时长：","时长（秒）: ${details.devTimeB}"));
      widgets.add(buildConfirmItem(details, "其他说明：","${details.note}"));
      return widgets;
  }

  Widget buildConfirmItem(DevDetails details,String title,String desc){
    return MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                  child: ListTile(
                    dense: false,
                    title: Text(title),
                    subtitle: Text(desc),
                  ),
        )
    );
  }

  void toDevPage(DevDetails details){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevPage(details)));
  }
}
