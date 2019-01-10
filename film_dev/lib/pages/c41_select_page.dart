
import 'package:film_dev/bloc/dev_detail_bloc.dart';
import 'package:film_dev/model/config.dart';
import 'package:film_dev/pages/dev_page_custom_dart.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class C41SelectPage extends StatefulWidget {
  C41SelectPage();

  @override
  _C41SelectPageState createState() => _C41SelectPageState();
}

class _C41SelectPageState extends State<C41SelectPage> {
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
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
              margin: const EdgeInsets.fromLTRB(24,0,24.0,10),
              child: Column(
                children: <Widget>[
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
                          child: Text("选择冲洗程序",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize
                            ),),
                        ),
                      )
                  ),
                    buildLoadingResultView(),
                ],
              )
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
    process.add(Process(Constant.DEV_C41_COMMON, "C41通用",c41Common));
    process.add(Process(Constant.DEV_C41_ARISTA_LIQUID, "C41 ARISTA_LIQUID",c41AristaLiquid));
    process.add(Process(Constant.DEV_C41_ROLLEI_DIGIBASE, "C41 ROLLEI_DIGIBASE",c41RolleiDigitalBase));
    process.add(Process(Constant.DEV_C41_TETENAL_COLORTEC, "C41 TETENAL_COLORTEC",c41TetenalColortec));
    process.add(Process(Constant.DEV_C41_UNICOLOR_POWER, "C41 UNICOLOR_POWER",c41UniColorPower));
  }
  // 展示查询结果
  Widget buildLoadingResultView(){
    return Expanded(
        child:Card(
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
            child:buildMedicInfo(context)
        )
    );
  }

  Widget buildMedicInfo(BuildContext context){
    Iterable<Widget> listTiles = process.map<Widget>((Process item) => buildItem(context, item));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return Scrollbar(
    child: ListView(
      padding: EdgeInsets.fromLTRB(0,10,0,0),
      children: listTiles.toList(),
    ),
    );
  }
  Widget buildItem(BuildContext context,Process info){
    return Material(
        color: Colors.grey[800],
        child: new InkWell(
          onTap: (){
                toCustomDevPage(info.procedure);
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
  toCustomDevPage(List<ProcedureItem> info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevPageCustom(info)));
  }
}

