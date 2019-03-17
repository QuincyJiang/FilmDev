
import 'package:film_dev/bloc/dev_detail_bloc.dart';
import 'package:film_dev/model/config.dart';
import 'package:film_dev/pages/dev_page_custom_dart.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class ECN2SelectPage extends StatefulWidget {
  ECN2SelectPage();

  @override
  _ECN2SelectPageState createState() => _ECN2SelectPageState();
}

class _ECN2SelectPageState extends State<ECN2SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: DevDetailBloc(),
        child:BlocC41Page(),
      ),
    );
  }
}

class BlocC41Page extends StatefulWidget {
  BlocC41Page();

  @override
  _BlocC41PageState createState() => _BlocC41PageState();
}


class _BlocC41PageState extends State<BlocC41Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Process> process = List();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
              padding:EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child:SafeArea(
                top: false,
                bottom: false,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(24,0,24.0,10),
                    child: Column(
                        children: <Widget>[
                    Container(
                    child:Center(
                        child: Text(
                      "ENC2",
                      style: textTheme.caption.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontSize: 70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ),
                  constraints:  BoxConstraints.expand(height: 150),
                ),
                          Card(
                              elevation: 1,
                              margin: EdgeInsets.fromLTRB(0,0,0,0),
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
                                  child: Text("选择冲洗药水",
                                    style: TextStyle(
                                        fontSize: Theme.of(context).textTheme.subhead.fontSize
                                    ),),
                                ),
                              )
                          ),buildLoadingResultView(),
                        ])),
              )
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    List<ProcedureItem> c41Common = new List();
    List<ProcedureItem> c41AristaLiquid = new List();
    List<ProcedureItem> c41TetenalColortec = new List();
    List<ProcedureItem> c41UniColorPower = new List();
    List<ProcedureItem> c41RolleiDigitalBase = new List();
    c41Common.add(ProcedureItem("彩显", 195, "温度 37.8 ± 0.15 ℃ "));
    c41Common.add(ProcedureItem("漂白", 260, "温度 38 ± 3 ℃ "));
    c41Common.add(ProcedureItem("水洗", 65, "温度 38 ± 3 ℃ "));
    c41Common.add(ProcedureItem("定影", 260, "温度 38 ± 3 ℃ "));
    c41Common.add(ProcedureItem("水洗", 195, "温度 38 ± 3 ℃ "));
    c41Common.add(ProcedureItem("稳定", 65, "温度 24 ℃ "));

    c41AristaLiquid.add(ProcedureItem("前浴",60,"温度 38.9 ℃"));
    c41AristaLiquid.add(ProcedureItem("彩显",240,"温度 38.9 ℃ \n前10s持续搅拌，之后每30s上下翻转冲洗罐4次，翻转后可轻碰冲洗罐底部以移除附着在片轴上的气泡"));
    c41AristaLiquid.add(ProcedureItem("漂白",390,"温度 35.0 - 40.5 ℃ \n前10s持续搅拌，之后每30s上下翻转冲洗罐4次，翻转后可轻碰冲洗罐底部以移除附着在片轴上的气泡"));
    c41AristaLiquid.add(ProcedureItem("水洗",180,"温度 35.0 - 40.5 ℃ \n使用流动清水持续冲洗" ));
    c41AristaLiquid.add(ProcedureItem("稳定",60,"温度 24 ℃ \n前15s持续搅拌"));

    c41TetenalColortec.add(ProcedureItem("前浴", 60, "温度 38 ± 0.5 ℃"));
    c41TetenalColortec.add(ProcedureItem("彩显", 195, "温度 38 ± 0.3 ℃"));
    c41TetenalColortec.add(ProcedureItem("漂白定影", 240, "温度 38 ± 1.0 ℃"));
    c41TetenalColortec.add(ProcedureItem("水洗", 180, "温度 30 - 40 ℃ \n使用流动清水持续冲洗，每30s换一次水 或者延长冲洗时间"));
    c41TetenalColortec.add(ProcedureItem("稳定", 60, "温度 20 - 40 ℃"));

    c41RolleiDigitalBase.add(ProcedureItem("前浴", 120, "温度 25 ℃"));
    c41RolleiDigitalBase.add(ProcedureItem("彩显", 780, "温度 25 ℃ \n前15s 翻转一次冲洗罐，之后每30s搅拌一次"));
    c41RolleiDigitalBase.add(ProcedureItem("漂白", 360, "温度 25 ℃ \n前15s 翻转一次冲洗罐，之后每30s搅拌一次"));
    c41RolleiDigitalBase.add(ProcedureItem("定影", 420, "温度 25 ℃\n前15s 翻转一次冲洗罐，之后每30s搅拌一次"));
    c41RolleiDigitalBase.add(ProcedureItem("水洗", 180, "温度 25 ℃\n使用流动清水持续冲洗"));
    c41RolleiDigitalBase.add(ProcedureItem("稳定", 90, "温度 25 ℃ \n前15s 翻转一次冲洗罐，之后每30s搅拌一次"));

    c41UniColorPower.add(ProcedureItem("前浴", 60, "温度 38.8 ℃"));
    c41UniColorPower.add(ProcedureItem("彩显", 210, "温度 38.8 ℃ \n前15s 翻转一次冲洗罐，之后每30s上下翻转冲洗罐4次，翻转后可轻碰冲洗罐底部以移除附着在片轴上的气泡"));
    c41UniColorPower.add(ProcedureItem("漂白定影", 390, "温度 38.8 ℃ \n前15s 翻转一次冲洗罐，之后每30s上下翻转冲洗罐4次，翻转后可轻碰冲洗罐底部以移除附着在片轴上的气泡"));
    c41UniColorPower.add(ProcedureItem("水洗", 180, "温度 35 - 40.5 ℃ \n使用清水浸泡3分钟后倒出"));
    c41UniColorPower.add(ProcedureItem("稳定", 75, "温度 35 - 40.5 ℃ \n前15s持续搅拌，之后静置一分钟"));

    process.add(Process(Constant.DEV_C41_COMMON, "C41罐冲通用程序",c41Common));
    process.add(Process(Constant.DEV_C41_ARISTA_LIQUID, "Arista Liquid C41罐冲",c41AristaLiquid));
    process.add(Process(Constant.DEV_C41_ROLLEI_DIGIBASE, "RolleiDigitalBase C41 罐冲",c41RolleiDigitalBase));
    process.add(Process(Constant.DEV_C41_TETENAL_COLORTEC, "Tetenal Colortec C41 滚冲",c41TetenalColortec));
    process.add(Process(Constant.DEV_C41_UNICOLOR_POWER, "UniColorPower 罐冲",c41UniColorPower));
  }
  // 展示查询结果
  Widget buildLoadingResultView(){
    return Card(
            elevation: 1,
            margin: EdgeInsets.fromLTRB(0,10,0,20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.0),
                topRight: Radius.circular(2.0),
                bottomLeft: Radius.circular(2.0),
                bottomRight: Radius.circular(2.0),
              ),
            ),
            child:Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildMedicInfo(context))
        );
  }

  List<Widget> buildMedicInfo(BuildContext context) {
    List<Widget> widgets = new List();
    int i = 0;
    if (process != null) process.forEach((data){
      widgets.add(
          Material(
              color: Colors.grey[800],
              child: new InkWell(
                onTap: (){
                  toCustomDevPage(data);
                },
                child:  MergeSemantics(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: ListTile(
                        dense: false,
                        title: Text(data.name),
                      ),)
                ),
              )
          )
      );
      // 添加分割线
      if(i!= process.length-1){
        widgets.add(Container(
          constraints: BoxConstraints(maxHeight: 1),
          decoration: BoxDecoration(color: Colors.grey[700]),
        ));
      }
      i++;
    }
    );
    return widgets;
  }

//  Widget buildMedicInfo(BuildContext context){
//    Iterable<Widget> listTiles = process.map<Widget>((Process item) => buildItem(context, item));
//    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
//    return Scrollbar(
//    child: ListView(
//      padding: EdgeInsets.fromLTRB(0,10,0,0),
//      children: listTiles.toList(),
//    ),
//    );
//  }
  Widget buildItem(BuildContext context,Process info){
    return Material(
        color: Colors.grey[800],
        child: new InkWell(
          onTap: (){
                toCustomDevPage(info);
          },
          child:  MergeSemantics(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 9),
                child: ListTile(
                  dense: false,
                  title: Text(info.name),
                ),)
          ),
        )
    );
  }
  // 去下一页
  toCustomDevPage(Process info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevPageCustom(info)));
  }
}

