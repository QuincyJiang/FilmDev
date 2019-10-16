import 'dart:async';

import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class DevDetailBloc implements IBlocBase{
  StreamController<List<DevDetails>> _devInfoController = new StreamController();
  Stream<List<DevDetails>> get outDevInfos => _devInfoController.stream;

  StreamController<DevInfoLoadingAnimAction> _devInfoLoadingStatusController = new StreamController();
  Stream<DevInfoLoadingAnimAction> get outDevInfoAnim => _devInfoLoadingStatusController.stream;
  Sink<DevInfoLoadingAnimAction> get  _inDevInfo => _devInfoLoadingStatusController.sink;

  StreamController<String> _titieAnimController = new StreamController();
  Stream<String> get outTitleAnim => _titieAnimController.stream;
  Sink<String> get  _inTitleAnim => _titieAnimController.sink;


  void dispose() {
    _titieAnimController.close();
    _devInfoController.close();
    _devInfoLoadingStatusController.close();
  }

  void queryPushedIso(DevInfo data){
    updateQueryAnim(DevInfoLoadingAnimAction(null, "loading", true));
    DbManager.instance.getDevDetails(data).then((List<Map> devs){
      List<DevDetails> queryResults = new List();
      if(devs == null || devs.length == 0){
        showEmpty();
        return;
      }
      try{
        for (var value in devs) {
          DevDetails dev = DevDetails.fromMap(value);
          dev.medic = data;
          queryResults.add(dev);
        }
      } catch(e){
        showLoadErrorAnim();
        return;
      }
      showLoadFinishAnim(queryResults);
    }).catchError((Object exception){
      showLoadErrorAnim();
    }).timeout(Duration(seconds: 4),onTimeout:(){
      showEmpty();
    });
  }
  // 更新查询数据的状态动画
  void updateQueryAnim(DevInfoLoadingAnimAction anim){
    _inDevInfo.add(anim);
  }

  void updateTitleAnim(String anim){
    _inTitleAnim.add(anim);
  }
  void showLoadErrorAnim(){
    updateQueryAnim(DevInfoLoadingAnimAction(null, "error2", true));
  }
  void showLoadFinishAnim(List<DevDetails> data){
    updateQueryAnim(DevInfoLoadingAnimAction(data, "idle", false));
  }

  void showEmpty(){
    updateQueryAnim(DevInfoLoadingAnimAction(null, "empty", true));
  }
}