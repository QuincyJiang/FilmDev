import 'dart:collection';
import 'package:film_dev/bloc/film_brand_bloc.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/dev_medic_select_page.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:film_dev/widgets/entry_item.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AllFilmSelectPage extends StatefulWidget {
  AllFilmSelectPage();

  @override
  _AllFilmSelectPageState createState() => _AllFilmSelectPageState();
}

class _AllFilmSelectPageState extends State<AllFilmSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: FilmInfoBloc(),
        child:BlocAllFilmPage(),
      ),
    );
  }
}

class BlocAllFilmPage extends StatefulWidget {
  BlocAllFilmPage();

  @override
  _BlocAllFilmPageState createState() => _BlocAllFilmPageState();
}


class _BlocAllFilmPageState extends State<BlocAllFilmPage> {
  List<DevInfo> devInfos;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FilmInfoBloc devBloc = BlocProvider.of<FilmInfoBloc>(context);
    devBloc.queryAllFilm();
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
                          child: Text("所有胶片",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize
                            ),),
                        ),
                      )
                  ),
                  StreamBuilder<FilmInfoListLoadingAnimAction>(
                      stream: devBloc.outLoadingAnim,
                      initialData: FilmInfoListLoadingAnimAction.empty(),
                      builder: (BuildContext context,AsyncSnapshot<FilmInfoListLoadingAnimAction> snapshot){
                        if(snapshot.data.loading){
                          return  buildLoadingView(devBloc,snapshot,);
                        }else{
                          return buildLoadingResultView(devBloc, snapshot);
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
  Widget buildLoadingView(FilmInfoBloc infoBloc,AsyncSnapshot<FilmInfoListLoadingAnimAction> snapshot){
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: GestureDetector(child: Container(child: new FlareActor(
          "assets/loading.flr", alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "${snapshot.data.anim}"),
        constraints: BoxConstraints.expand(height: 100),),
        onTap: () {
          infoBloc.queryAllFilm();
        },),
    );
  }

  Widget buildEmptyPage(){
    return Container(width: 0,height: 0,);
  }
  // 展示查询结果
  Widget buildLoadingResultView(FilmInfoBloc infoBloc,AsyncSnapshot<FilmInfoListLoadingAnimAction> snapshot){
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
            child:buildFilmInfo(context, snapshot.data.data)
        )
    );
  }

  Widget buildFilmInfo(BuildContext context, LinkedHashMap<String,List<FilmInfo>> datas){
    List<Widget> listTiles = buildItems(datas);
//    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return Scrollbar(
        child: ListView.builder(
            itemBuilder: (context,i) {
              return listTiles[i];
              },
            itemCount: datas.length));
  }
  List<Widget> buildItems(LinkedHashMap<String,List<FilmInfo>> datas){
    List<Widget> listTiles = List();
    datas.forEach((key,value){
      List<Entry> children = new List();
      value.forEach((film){
        children.add(Entry(film,null));
      });
      Entry root = Entry(FilmInfo.fromName(key),children);
      listTiles.add(EntryItem(root));
    });
    return listTiles;
  }
  // 去下一页
  toSelectResultPage(FilmInfo info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevMedicSelectPage(info)));
  }
}