
import 'package:film_dev/bloc/dev_detail_bloc.dart';
import 'package:film_dev/model/config.dart';
import 'package:film_dev/pages/dev_page_custom_dart.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class E6SelectPage extends StatefulWidget {
  E6SelectPage();

  @override
  _E6SelectPageState createState() => _E6SelectPageState();
}

class _E6SelectPageState extends State<E6SelectPage> {
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
                      "E6",
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
    List<ProcedureItem> e6Common = new List();
    e6Common.add(ProcedureItem("首显", 360, "温度 37.8 ℃ \n"
        "注意：首显对时间和温度敏感，时间和显影温度会影响反差"));
    e6Common.add(ProcedureItem("水洗", 120, "温度 37.8 ℃ "));
    e6Common.add(ProcedureItem("反转", 120, "温度 35.6-39.4 °C "));
    e6Common.add(ProcedureItem("彩显", 360, "温度 35.6-39.4 °C  "));
    e6Common.add(ProcedureItem("预漂白", 120, "温度 32.2-39.4 °C "));
    e6Common.add(ProcedureItem("漂白", 360, "温度 33.3-39.4 °C "));
    e6Common.add(ProcedureItem("水洗[可选]", 120, "温度 33.3-39.4 °C "));
    e6Common.add(ProcedureItem("定影", 240, "温度 33.3-39.4 °C "));
    e6Common.add(ProcedureItem("二次定影[可选]", 240, "温度 33.3-39.4 °C "));
    e6Common.add(ProcedureItem("水洗", 240, "温度 33.3-39.4 °C "));
    e6Common.add(ProcedureItem("稳定", 60, "温度 26.7-39.4 °C "));
    e6Common.add(ProcedureItem("干燥", 300, "温度 室温 "));

    process.add(Process(Constant.DEV_E6_COMMON, "E6标准程序",e6Common));
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

