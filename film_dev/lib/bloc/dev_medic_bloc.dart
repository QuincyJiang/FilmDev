import 'dart:async';

import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class DevMedicBloc implements IBlocBase{
  StreamController<List<DevInfo>> _devInfoController = new StreamController();
  Stream<List<DevInfo>> get outDevInfos => _devInfoController.stream;
  Sink<List<DevInfo>> get  _inDevs => _devInfoController.sink;

  StreamController<DevInfoAnimAction> _devInfoLoadingStatusController = new StreamController();
  Stream<DevInfoAnimAction> get outDevInfoAnim => _devInfoLoadingStatusController.stream;
  Sink<DevInfoAnimAction> get  _inDevInfo => _devInfoLoadingStatusController.sink;

  StreamController<String> _titieAnimController = new StreamController();
  Stream<String> get outTitleAnim => _titieAnimController.stream;
  Sink<String> get  _inTitleAnim => _titieAnimController.sink;


  void dispose() {
    _devInfoController.close();
    _devInfoLoadingStatusController.close();
  }

  void queryDev(FilmInfo info){
    updateQueryAnim(DevInfoAnimAction(null, "loading", true));
    DbManager.instance.getDevInfo(info).then((List<Map> devs){
      List<DevInfo> queryResults = new List();
      if(devs == null || devs.length == 0){
        showEmpty();
        return;
      }
      try{
        for (var value in devs) {
          DevInfo dev = DevInfo.fromMap(value);
          dev.filmInfo = info;
          queryResults.add(dev);
        }
      } catch(e){
        showLoadErrorAnim();
        return;
      }
      showLoadFinishAnim(queryResults);
    }).catchError((){
      showLoadErrorAnim();
    }).timeout(Duration(seconds: 4),onTimeout:(){
      showEmpty();
    });
  }
  // 更新查询数据的状态动画
  void updateQueryAnim(DevInfoAnimAction anim){
    _inDevInfo.add(anim);
  }

  void updateTitleAnim(String anim){
    _inTitleAnim.add(anim);
  }
  void showLoadErrorAnim(){
    updateQueryAnim(DevInfoAnimAction(null, "error2", true));
  }
  void showLoadFinishAnim(List<DevInfo> data){
    updateQueryAnim(DevInfoAnimAction(data, "idle", false));
  }
  void showEmpty(){
    updateQueryAnim(DevInfoAnimAction(null, "empty", true));
  }
}