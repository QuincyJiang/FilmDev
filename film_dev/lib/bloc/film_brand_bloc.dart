import 'dart:async';
import 'dart:collection';
import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class FilmInfoBloc implements IBlocBase{
  FilmInfo _filmInfo;
  // 负责表单标题随选项联动的bloc
  StreamController<FilmInfo> _titleHintController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get _inTitleHint => _titleHintController.sink;
  Stream<FilmInfo> get outTitleHint => _titleHintController.stream;
  //负责更新widget中创建的filmInfo的值 该值会用作查询数据库的key 当表单内容有变动它会更新 同时上面负责联动标题栏的bloc也会响应
  StreamController<FilmInfo> _changedFilmInfoController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get updateFilmInfo => _changedFilmInfoController.sink;
  // 控制下方loading动画的bloc
  StreamController<LoadingAnimAction> _updateLoadingStatus = StreamController<LoadingAnimAction>.broadcast();
  Sink<LoadingAnimAction> get _loadingStatus => _updateLoadingStatus.sink;
  Stream<LoadingAnimAction> get outLoadingStatus => _updateLoadingStatus.stream;

  StreamController<String> _titieAnimController = new StreamController();
  Stream<String> get outTitleAnim => _titieAnimController.stream;
  Sink<String> get  _inTitleAnim => _titieAnimController.sink;

  StreamController<FilmInfoListLoadingAnimAction> _loadingResultController = new StreamController();
  Stream<FilmInfoListLoadingAnimAction> get outLoadingAnim => _loadingResultController.stream;
  Sink<FilmInfoListLoadingAnimAction> get  _inLoadingAnim => _loadingResultController.sink;



  FilmInfoBloc(){
    _changedFilmInfoController.stream.listen(filmInfoChanged);
  }
  void dispose() {
    _updateLoadingStatus.close();
    _titieAnimController.close();
    _titleHintController.close();
    _changedFilmInfoController.close();
  }

  void filmInfoChanged(FilmInfo info){
    _filmInfo = info;
    _inTitleHint.add(_filmInfo);
  }
  // 更新查询数据的状态动画
  void updateQueryAnim(LoadingAnimAction anim){
    _loadingStatus.add(anim);
  }
  // 查询数据接口
  void queryFilmInfo(FilmInfo info) async {
    updateQueryAnim(LoadingAnimAction(null, "loading", true));
     DbManager.instance.getFilmInfo(info).then((List<Map> films){
      List<FilmInfo> queryResults = new List();
      if(films == null || films.length == 0){
        showEmpty();
        return;
      }
      try{
        for (var value in films) {
            queryResults.add(FilmInfo.fromMap(value));
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
  // 查询数据接口
  void queryAllFilm() async {
//    updateQueryAnim(LoadingAnimAction(null, "loading", true));
  updateListLoadingAnim(FilmInfoListLoadingAnimAction(null, "loading", true));
    DbManager.instance.getAllFilmInfo().then((LinkedHashMap<String,List<FilmInfo>> films){
      if(films == null || films.length == 0){
        showFilmListEmpty();
        return;
      }
      showFilmListLoadingFinish(films);
    }).catchError((){
      showFilmListLoadingError();
    }).timeout(Duration(seconds: 4),onTimeout:(){
      showFilmListEmpty();
    });
  }

  void updateTitleAnim(String anim){
    _inTitleAnim.add(anim);
  }

  void showLoadErrorAnim(){
    updateQueryAnim(LoadingAnimAction(null, "error2", true));
  }
  void showLoadFinishAnim(List<FilmInfo> data){
    updateQueryAnim(LoadingAnimAction(data, "idle", false));

  }
  void showEmpty(){
    updateQueryAnim(LoadingAnimAction(null, "empty", true));
  }

  void showFilmListLoadingError(){
    updateListLoadingAnim(FilmInfoListLoadingAnimAction(null,"error2",true));
  }
  void showFilmListLoadingFinish(LinkedHashMap<String,List<FilmInfo>> data){
    updateListLoadingAnim(FilmInfoListLoadingAnimAction(data,"idle",false));
  }
  void showFilmListEmpty(){
    updateListLoadingAnim(FilmInfoListLoadingAnimAction(null,"empty",true));
  }

  // 更新查询数据的状态动画
  void updateListLoadingAnim(FilmInfoListLoadingAnimAction anim){
    _inLoadingAnim.add(anim);
  }
}
