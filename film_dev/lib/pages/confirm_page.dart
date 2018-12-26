
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
          child: Text("冲洗配置",
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
            ),),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      ),
    ],
    )
    )
        )
    ));}


  String _validVol(String value) {
    if (value.isEmpty)
      return '数据不可为空';
    if(!checkVaild(value)){
      return '输入一个合理的数字';
    }
    return null;
  }


  // 展示查询结果
  Widget buildLoadingResultView(DevDetails details){
    return Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildConfirmIist(context,details));
  }

  List<Widget> buildConfirmIist(BuildContext context,DevDetails details){
      List<Widget> widgets = new List();
      widgets.add(buildConfirmItem(details, "胶片",details.medic.filmInfo.brand+" "+ details.medic.filmInfo.name,false));
      widgets.add(buildConfirmItem(details, "药液", details.medic.medicName,false));
      widgets.add(Material(
              color: Colors.grey[800],
              child: new InkWell(
                  onTap: (){
                    showVolConfigDialog(context,details);
                  },
              child:  buildConfirmItem(details, "配比", getProp(details),true),))
      );
      widgets.add(buildConfirmItem(details, "迫冲","原生ISO: ${details.medic.filmInfo.iso} \n目标ISO: ${details.iso}",false));
      widgets.add(buildConfirmItem(details, "冲洗温度","恒温（℃）：${details.temper}",false));
      widgets.add(buildConfirmItem(details, "阶段A显影时长","时长（秒）: ${details.devTimeA}",false));
      widgets.add(buildConfirmItem(details, "阶段B显影时长","时长（秒）: ${details.devTimeB}",false));
      widgets.add(buildConfirmItem(details, "其他说明","${details.note}",false));
      return widgets;
  }

  String getProp(DevDetails detail){
    if(detail.medic.concentrate){
      return "${detail.medic.medicName}: ${detail.medic.medicVolume} ml \n"
             "纯净水:${detail.medic.waterVolume} ml \n"
             "制成工作液：${detail.medic.totalVolume} ml";
    }else{
      return "${detail.medic.medicName}  ${detail.medic.totalVolume} ml";
    }
  }

  Widget buildConfirmItem(DevDetails details,String title,String desc,bool showArrow){
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

  void toDevPage(DevDetails details){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevPage(details)));
  }

  void showVolConfigDialog(BuildContext context, DevDetails data){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('要配制多少工作液？'),
          content:Form(
          key: _formKey,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '配制你需要的工作液容量',
                labelText: '工作液',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 3,
              onSaved: (value){
                setState(() {
                    widget.details.medic.setTotalVolumn(double.parse(value));
                });
              },
              validator: _validVol,
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text('取消'),
                onPressed: () { Navigator.pop(context); }
            ),
            FlatButton(
                child: const Text('确认'),
                onPressed: () {
                  _handleSubmitted();
                }
            )
          ]
      ),
    );
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pop(context);
    }
  }

  bool checkVaild(String input){
    try{
      double.parse(input);
      return true;
    }catch(e){
      return false;
    }
  }
  void showInSnackBar(String value){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
}
