import 'dart:async';

import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/fav_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class MyFavBloc implements IBlocBase{
  StreamController<List<DevInfo>> _devInfoController = new StreamController();
  Stream<List<DevInfo>> get outDevInfos => _devInfoController.stream;

  StreamController<FavInfoAnimAction> _devInfoLoadingStatusController = new StreamController();
  Stream<FavInfoAnimAction> get outDevInfoAnim => _devInfoLoadingStatusController.stream;
  Sink<FavInfoAnimAction> get  _inDevInfo => _devInfoLoadingStatusController.sink;

  StreamController<String> _titieAnimController = new StreamController();
  Stream<String> get outTitleAnim => _titieAnimController.stream;
  Sink<String> get  _inTitleAnim => _titieAnimController.sink;


  void dispose() {
    _titieAnimController.close();
    _devInfoController.close();
    _devInfoLoadingStatusController.close();
  }

  void queryFav(){
    updateQueryAnim(FavInfoAnimAction(null, "loading", true));
    DbManager.instance.getFav().then((List<FavInfo> devs){
      if(devs == null || devs.length == 0){
        showEmpty();
        return;
      }
      showLoadFinishAnim(devs);
    }).catchError((){
      showLoadErrorAnim();
    }).timeout(Duration(seconds: 4),onTimeout:(){
      showEmpty();
    });
  }
  // 更新查询数据的状态动画
  void updateQueryAnim(FavInfoAnimAction anim){
    _inDevInfo.add(anim);
  }

  void updateTitleAnim(String anim){
    _inTitleAnim.add(anim);
  }
  void showLoadErrorAnim(){
    updateQueryAnim(FavInfoAnimAction(null, "error2", true));
  }
  void showLoadFinishAnim(List<FavInfo> data){
    updateQueryAnim(FavInfoAnimAction(data, "idle", false));
  }
  void showEmpty(){
    updateQueryAnim(FavInfoAnimAction(null, "empty", true));
  }
}