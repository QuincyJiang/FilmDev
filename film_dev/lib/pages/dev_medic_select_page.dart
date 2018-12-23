import 'package:film_dev/bloc/dev_medic_bloc.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/pushd_iso_confirm_page.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DevMedicSelectPage extends StatefulWidget {
  final FilmInfo _film;
  DevMedicSelectPage(this._film);

  @override
  _DevMedicSelectPageState createState() => _DevMedicSelectPageState();
}

class _DevMedicSelectPageState extends State<DevMedicSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: DevMedicBloc(),
        child:BlocDevPage(widget._film),
      ),
    );
  }
}

class BlocDevPage extends StatefulWidget {
  final FilmInfo _filmInfo;
  BlocDevPage(this._filmInfo);

  @override
  _BlocDevPageState createState() => _BlocDevPageState();
}


class _BlocDevPageState extends State<BlocDevPage> {
  List<DevInfo> devInfos;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final DevMedicBloc devBloc = BlocProvider.of<DevMedicBloc>(context);
    final FilmInfo filmInfo = widget._filmInfo;
    devBloc.queryDev(filmInfo);
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
                      stream: devBloc.outTitleAnim,
                      initialData: "enter",
                      builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                          return Container(
                            child: new FlareActor("assets/medic.flr",
                                alignment:Alignment.center,
                                fit:BoxFit.contain,
                                callback: (status){
                              // 入场动画播放完毕后就开始播放水波纹动画
                                  devBloc.updateTitleAnim("wave");
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
                          child: Text("Select Developer",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize
                            ),),
                        ),
                      )
                  ),
                  StreamBuilder<DevInfoAnimAction>(
                      stream: devBloc.outDevInfoAnim,
                      initialData: DevInfoAnimAction.empty(),
                      builder: (BuildContext context,AsyncSnapshot<DevInfoAnimAction> snapshot){
//                        devBloc.updateTitleAnim("wave");
                        if(snapshot.data.loading){
                          return  buildLoadingView(filmInfo,devBloc,snapshot,);
                        }else{
                          return buildLoadingResultView(filmInfo,devBloc, snapshot);
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
  Widget buildLoadingView(FilmInfo info,DevMedicBloc infoBloc,AsyncSnapshot<DevInfoAnimAction> snapshot){
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: GestureDetector(child: Container(child: new FlareActor(
          "assets/loading.flr", alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "${snapshot.data.anim}"),
        constraints: BoxConstraints.expand(height: 100),),
        onTap: () {
          infoBloc.queryDev(info);
        },),
    );
  }

  Widget buildEmptyPage(){
    return Container(width: 0,height: 0,);
  }
  // 展示查询结果
  Widget buildLoadingResultView(FilmInfo info,DevMedicBloc infoBloc,AsyncSnapshot<DevInfoAnimAction> snapshot){
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

  Widget buildMedicInfo(BuildContext context, List<DevInfo> datas){
    Iterable<Widget> listTiles = datas.map<Widget>((DevInfo item) => buildItem(context, item));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return Scrollbar(
   child: ListView.builder(
        itemBuilder: (context,i){
          return listTiles.toList()[i];},
    itemCount: datas.length));
  }
  Widget buildItem(BuildContext context,DevInfo info){
    return Material(
        color: Colors.grey[800],
        child: new InkWell(
          onTap: (){
            toSelectIsoPage(info);
          },
          child:  MergeSemantics(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                child: ListTile(
                  dense: false,
                  title: Text('${info.medicName}  ${info.dilution}'),
                  subtitle: Text("Film: ${info.filmInfo.name}"),
                ),)
          ),
        )
    );
  }
  // 去下一页
  toSelectIsoPage(DevInfo info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevIsoSelectPage(info)));
  }
}

