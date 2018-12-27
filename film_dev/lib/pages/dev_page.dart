import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/pages/collection_page.dart';
import 'package:film_dev/utils/device_util.dart';
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
  final String ANIM_ENTER = "enter";
  final String ANIM_FLICKER = "flicker";
  final String ANIM_DARKFLICKER = "darkFlicker";
  final String ANIM_ON = "on";
  final String ANIM_OFF = "off";
  static const String TYPE_FIX = "定影";
  static const String TYPE_WASH = "水洗";
  static const String TYPE_HYPO = "去海波";
  static const String TYPE_STOP = "停显";
  bool isDarkMode = false;
  String anim = "enter";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DeviceUtil.instance.exitFullScreen();
  }
  @override
  Widget build(BuildContext context) {
    DeviceUtil.instance.enterFullScreen();
    return Theme(
      data: ThemeData(
        primaryColor:isDarkMode? Colors.black:Colors.black,
        accentColor: isDarkMode?Colors.black:Colors.grey[900],
        cardColor: isDarkMode? Colors.black:Colors.grey[800],
        scaffoldBackgroundColor:isDarkMode? Colors.black:Colors.grey[850],
        textTheme: TextTheme(
          subhead: TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
          subtitle:TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
          title:TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
          display1:TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
          display2:TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
          caption:TextStyle(
            color: isDarkMode? Colors.grey[900]:Colors.white,
          ),
        ), iconTheme: IconThemeData(
            color: isDarkMode? Colors.grey[900]:Colors.white,
      )
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
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
                            animation:anim),
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
                                child: Text(isDarkMode?"暗房模式":"开始冲洗",
                                  style: TextStyle(
                                    color: isDarkMode? Colors.grey[900]:Colors.white,
                                    fontSize: Theme.of(context).textTheme.subhead.fontSize
                                  ),
                                ),
                              ),
                            )
                        ),
                        buildTimerItem("显影A", "前一分钟持续搅拌，之后每分钟开始时搅拌5-10s\n"
                            "其他说明:\n ${widget.details.note}", widget.details.devTimeA,false,""),
                        (widget.details.devTimeB == 0)?Container(height: 0,width: 0,):buildTimerItem("显影B", "点击开启计时，长按重置计时器", widget.details.devTimeB,false,""),
                        buildTimerItem("停显", "停显时间请参考您使用的停显液", widget.details.stopTime,true,TYPE_STOP),
                        buildTimerItem("定影", "定影时间请参考您使用的定影液", widget.details.fixTime,true,TYPE_FIX),
                        buildTimerItem("去海波", "使用特定的海波清洗液去除残存海波", widget.details.hypoTime, true,TYPE_HYPO),
                        buildTimerItem("水洗", "使用流动清水持续冲洗", widget.details.washTime,true,TYPE_WASH),
                        buildTimerItem("稳定", "使用水滴斑防止液稳定您的底片", 60,false,""),
            new Material(
              color: isDarkMode?Colors.black:Colors.yellow[900],
              child: new InkWell(
                  onTap: (){
                    showSaveDialog(context, widget.details);
                  },
                  child: Center(
                    child: Padding(padding:EdgeInsets.all(10),
                      child: Text("添加收藏",
                        style: TextStyle(
                            fontSize: Theme.of(context).textTheme.subhead.fontSize,
                            color: isDarkMode? Colors.grey[900]:Colors.white
                        ),
                      ),
                    ),
                  )
              ),),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                      ],
                    )
                )
            )
        )));}

        void processAnim(){
         if(isDarkMode){
           setState(() {
             anim = ANIM_ON;
             isDarkMode = false;
           });
         }else{
           setState(() {
             anim = ANIM_OFF;
             isDarkMode = true;
           });
         }
        }
  Widget buildTimerItem(String title,String desp,int time,bool showArrow,String type){
    return Card(elevation: 1,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2.0),
          topRight: Radius.circular(2.0),
          bottomLeft: Radius.circular(2.0),
          bottomRight: Radius.circular(2.0),),),
        child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildConfirmItem(title, desp, showArrow, type),
              Container(constraints: BoxConstraints.expand(height: 70),
                child: CountDownWidget(
                  key: UniqueKey(), countDownSeconds: time, label: title,),),
            ]));
  }

  void save(String name,DevDetails details){
      if(name.isEmpty){
      DbManager.instance.getDefaultNameLength("默认收藏").then((size){
        String defalutName = "默认收藏${size++}";
        DbManager.instance.save(defalutName, details).then((index){
          showInSnackBar("已加入收藏夹，文件名${defalutName}");
        });
      });
      }else{
        DbManager.instance.isFavExist(name).then((bool){
          if(bool){
             DbManager.instance.getCollectionSize(name).then((size){
              String temp = name+"${size++}";
              DbManager.instance.save(temp, details).then((index){
                showInSnackBar("已有同名收藏文件,重命名为${temp}");
              });
             });
          }else{
            DbManager.instance.save(name, details).then((index){
              showInSnackBar("已加入收藏夹，文件名${name}");
            });
          }
        });
      }
  }

  void showInSnackBar(String value){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value,
        style: TextStyle(
          color: isDarkMode? Colors.grey[900]:Colors.white
        ),
        ),
      action: SnackBarAction(
        textColor: isDarkMode? Colors.grey[900]:Colors.white,
          label: "查看", onPressed: (){
        goToCollectionPage();
      }),
    ));
  }

  void goToCollectionPage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => CollectionPage()));
  }

  bool isInCollection(DevDetails details){
    return false;
  }

  void showTimerConfigDialog(BuildContext context, DevDetails data,String type){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title:  Text('定制你的${type}时间 （秒）'),
          content:Form(
            key: _formKey,
            child: TextFormField(
              decoration:InputDecoration(
                border: OutlineInputBorder(),
                hintText: '定制你的${type}时间 （秒）',
                labelText: "修改为你需要的${type}时间 （秒）",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              maxLines: 3,
              onSaved: (value){
                setState(() {
                  switch(type){
                    case TYPE_FIX:
                      setState(() {
                        widget.details.fixTime = int.parse(value);
                      });
                      break;
                    case TYPE_STOP:
                      setState(() {
                        widget.details.stopTime = int.parse(value);
                      });
                      break;
                      case TYPE_WASH:
                        setState(() {
                          widget.details.washTime = int.parse(value);
                        });
                      break;
                      case TYPE_HYPO:
                        setState(() {
                          widget.details.hypoTime = int.parse(value);
                        });
                      break;
                  }
                  widget.details.medic.setTotalVolumn(double.parse(value));
                });
              },
              validator: _validTime,
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
  void showSaveDialog(BuildContext context, DevDetails data){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title:  Text('输入收藏名'),
          content:Form(
            key: _formKey,
            child: TextFormField(
              decoration:InputDecoration(
                border: OutlineInputBorder(),
                hintText: '为你的收藏取个名字',
                labelText: "为你的收藏取个名字",
              ),
              keyboardType: TextInputType.text,
              maxLines: 2,
              onSaved: (value){
                save(value,data);
              },
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
  String _validTime(String value) {
    if (value.isEmpty)
      return '时间不可为空';
    if(!checkVaild(value)){
      return '输入一个合理的时长';
    }
    return null;
  }
  bool checkVaild(String input){
    try{
      double.parse(input);
      return true;
    }catch(e){
      return false;
    }
  }

  Widget buildConfirmItem(String title,String desc,bool showArrow,String type){
    if(showArrow){
      return  Material(
        color: isDarkMode?Colors.black:Colors.grey[800],
        child: new InkWell(
            onTap: (){
              showTimerConfigDialog(context,widget.details,type);
            },
            child:MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                  child: ListTile(
                    dense: false,
                    title: Text(title),
                    subtitle: Text(desc),
                    trailing: showArrow?Icon(Icons.arrow_right,
                    color: isDarkMode? Colors.grey[900]:Colors.white,):Container(height: 0,width: 0,),
                  ),
                )
            )
        ));
            }
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
