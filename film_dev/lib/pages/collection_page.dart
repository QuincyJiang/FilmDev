import 'package:film_dev/bloc/dev_medic_bloc.dart';
import 'package:film_dev/bloc/my_fav_comb_bloc.dart';
import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/fav_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/confirm_page.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:film_dev/utils/device_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeviceUtil.instance.exitFullScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: MyFavBloc(),
        child:BlocDevPage(new FilmInfo("Kodak", "Tmax", 200, "", 233)),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final MyFavBloc favBloc = BlocProvider.of<MyFavBloc>(context);
    favBloc.queryFav();
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
                      stream: favBloc.outTitleAnim,
                      initialData: "enter",
                      builder: (BuildContext context,AsyncSnapshot<String> snapshot){
                        return Container(
                          child: new FlareActor("assets/favorite.flr",
                              alignment:Alignment.center,
                              fit:BoxFit.contain,
                              callback: (status){
                                // 入场动画播放完毕后就开始播放水波纹动画
                                favBloc.updateTitleAnim("shine");
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
                          child: Text("收藏夹",
                            style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize
                            ),),
                        ),
                      )
                  ),
                  StreamBuilder<FavInfoAnimAction>(
                      stream: favBloc.outDevInfoAnim,
                      initialData: FavInfoAnimAction.empty(),
                      builder: (BuildContext context,AsyncSnapshot<FavInfoAnimAction> snapshot){
//                        devBloc.updateTitleAnim("wave");
                        if(snapshot.data.loading){
                          return  buildLoadingView(favBloc,snapshot,);
                        }else{
                          return buildLoadingResultView(favBloc, snapshot);
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
  Widget buildLoadingView(MyFavBloc infoBloc,AsyncSnapshot<FavInfoAnimAction> snapshot){
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: GestureDetector(child: Container(child: new FlareActor(
          "assets/loading.flr", alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "${snapshot.data.anim}"),
        constraints: BoxConstraints.expand(height: 100),),
        onTap: () {
          infoBloc.queryFav();
        },),
    );
  }

  Widget buildEmptyPage(){
    return Container(width: 0,height: 0,);
  }
  // 展示查询结果
  Widget buildLoadingResultView(MyFavBloc infoBloc,AsyncSnapshot<FavInfoAnimAction> snapshot){
    if(snapshot.data.data.length == 0){
      return buildEmptyPage();
    }
    return Expanded(
        child:Card(
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
            child:buildFavInfo(infoBloc,context, snapshot.data.data)
        )
    );
  }

  Widget buildFavInfo(MyFavBloc favBloc,BuildContext context, List<FavInfo> datas){
    Iterable<Widget> listTiles = datas.map<Widget>((FavInfo item) => buildItem(favBloc,context, item));
    listTiles = ListTile.divideTiles(context: context, tiles: listTiles);
    return Scrollbar(
          child: ListView(
            children: listTiles.toList(),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
    );
  }
  Widget buildItem(MyFavBloc favBloc,BuildContext context,FavInfo info){
    return Material(
        color: Colors.grey[800],
        child: new InkWell(
          onTap: (){
            toConfirmPage(info);
          },
          onLongPress: (){
            showDeleteConfigDialog(favBloc,context,info);
          },
          child:  MergeSemantics(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 8),
                child: ListTile(
                  dense: false,
                  title: Text('${info.name}'),
                  subtitle: Text("Film: ${info.data.medic.filmInfo.name} \nDeveloper: ${info.data.medic.medicName}"),
                ),)
          ),
        )
    );
  }

  void showDeleteConfigDialog(MyFavBloc favBloc,BuildContext context, FavInfo data){
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text('删除这条收藏吗？'),
          actions: <Widget>[
            FlatButton(
                child: const Text('取消'),
                onPressed: () { Navigator.pop(context); }
            ),
            FlatButton(
                child: const Text('确认'),
                onPressed: () {
                  deleteFav(favBloc,data);
                  Navigator.pop(context);
                }
            )
          ]
      ),
    );
  }
  void deleteFav(MyFavBloc favBloc,FavInfo info){
    DbManager.instance.deleteCollect(info.name).then((index){
      showInSnackBar("收藏 ${info.name} 已删除");
      favBloc.queryFav();
    });
    setState(() {

    });
  }

  void showInSnackBar(String value){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }

  toConfirmPage(FavInfo info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => ConfirmPage(info.data)));
  }
}


