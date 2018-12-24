import 'package:film_dev/bloc/dev_detail_bloc.dart';
import 'package:film_dev/bloc/dev_medic_bloc.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/confirm_page.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DevIsoSelectPage extends StatefulWidget {
  final DevInfo _devInfo;
  DevIsoSelectPage(this._devInfo);

  @override
  _DevIsoSelectPageState createState() => _DevIsoSelectPageState();
}

class _DevIsoSelectPageState extends State<DevIsoSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: DevDetailBloc(),
        child:BlocIsoPage(widget._devInfo),
      ),
    );
  }
}

class BlocIsoPage extends StatefulWidget {
  final DevInfo _devInfo;
  BlocIsoPage(this._devInfo);

  @override
  _BlocIsoPageState createState() => _BlocIsoPageState();
}


class _BlocIsoPageState extends State<BlocIsoPage> {
  List<DevInfo> devInfos;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final DevDetailBloc detailBloc = BlocProvider.of<DevDetailBloc>(context);
    final DevInfo devInfo = widget._devInfo;
    detailBloc.queryPushedIso(devInfo);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
              margin: const EdgeInsets.fromLTRB(24,0,24.0,10),
              child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                      stream: detailBloc.outTitleAnim,
                      initialData: "enter",
                      builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                        return Container(
                          child: new FlareActor("assets/iso.flr",
                              alignment:Alignment.center,
                              fit:BoxFit.contain,
                              callback: (status){
                                // 入场动画播放完毕后就开始播放跳动动画
                                detailBloc.updateTitleAnim("beat");
                              },
                              animation:"${snapshot.data}"),
                          constraints:  BoxConstraints.expand(height: 150),
                        );
                      }),
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
                          child: Text("选择迫冲感光度",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize
                            ),),
                        ),
                      )
                  ),
                  StreamBuilder<DevInfoLoadingAnimAction>(
                      stream: detailBloc.outDevInfoAnim,
                      initialData: DevInfoLoadingAnimAction.empty(),
                      builder: (BuildContext context,AsyncSnapshot<DevInfoLoadingAnimAction> snapshot){
//                        devBloc.updateTitleAnim("wave");
                        if(snapshot.data.loading){
                          return  buildLoadingView(devInfo,detailBloc,snapshot,);
                        }else{
                          return buildLoadingResultView(devInfo,detailBloc, snapshot);
                        }
                      }),
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
  }

  // 展示加载中的动画
  Widget buildLoadingView(DevInfo info,DevDetailBloc infoBloc,AsyncSnapshot<DevInfoLoadingAnimAction> snapshot){
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: GestureDetector(child: Container(child: new FlareActor(
          "assets/loading.flr", alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "${snapshot.data.anim}"),
        constraints: BoxConstraints.expand(height: 100),),
        onTap: () {
          infoBloc.queryPushedIso(info);
        },),
    );
  }

  Widget buildEmptyPage(){
    return Container(width: 0,height: 0,);
  }
  // 展示查询结果
  Widget buildLoadingResultView(DevInfo info,DevDetailBloc infoBloc,AsyncSnapshot<DevInfoLoadingAnimAction> snapshot){
    if(snapshot.data.data.length == 0){
      return buildEmptyPage();
    }
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
            child:buildMedicInfo(context, snapshot.data.data)
        )
    );
  }

  Widget buildMedicInfo(BuildContext context, List<DevDetails> datas){
    Iterable<Widget> listTiles = datas.map<Widget>((DevDetails item) => buildItem(context, item));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return Scrollbar(
        child: ListView.builder(
            itemBuilder: (context,i){
              return listTiles.toList()[i];},
            itemCount: datas.length));
  }
  Widget buildItem(BuildContext context,DevDetails info){
    return Material(
        color: Colors.grey[800],
        child: new InkWell(
          onTap: (){
            toConfirmPage(info);
          },
          child:  MergeSemantics(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                child: ListTile(
                  dense: false,
                  title: Text('ISO ${info.iso}'),
                  subtitle: Text("Film: ${info.medic.filmInfo.name} \nDeveloper: ${info.medic.medicName}"),
                ),)
          ),
        )
    );
  }
  // 去下一页
  toConfirmPage(DevDetails info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => ConfirmPage(info)));
  }
}

