import 'dart:async';
import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class FilmInfoBloc implements BlocBase{
  FilmInfo _filmInfo;
  // 负责表单标题随选项联动的bloc
  StreamController<FilmInfo> _titleHintController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get _inTitleHint => _titleHintController.sink;
  Stream<FilmInfo> get outTitleHint => _titleHintController.stream;
  //负责更新widget中创建的filmInfo的值 该值会用作查询数据库的key 当表单内容有变动它会更新 同时上面负责联动标题栏的bloc也会响应
  StreamController<FilmInfo> _changedFilmInfoController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get updateFilmInfo => _changedFilmInfoController.sink;
  // 控制下方loading动画的bloc
  StreamController<LoadingAnimAction> _updateArrowAnim = StreamController<LoadingAnimAction>.broadcast();
  Sink<LoadingAnimAction> get _arrowAnim => _updateArrowAnim.sink;
  Stream<LoadingAnimAction> get outArrowAnim => _updateArrowAnim.stream;

  FilmInfoBloc(){
    _changedFilmInfoController.stream.listen(filmInfoChanged);
  }
  void dispose() {
    _titleHintController.close();
    _changedFilmInfoController.close();
  }

  void filmInfoChanged(FilmInfo info){
    _filmInfo = info;
    _inTitleHint.add(_filmInfo);
  }
  // 更新查询数据的状态动画
  void updateQueryAnim(LoadingAnimAction anim){
    _arrowAnim.add(anim);
  }
  // 查询数据接口
  void queryFilmInfo(FilmInfo info){
//    DbManager.instance.getFilmInfo(info).then((List<FilmInfo> films){
//      //TODO: 完成查询接口
//    });
    updateQueryAnim(LoadingAnimAction(null, "loading", true));
    Future<List<FilmInfo>>.delayed(Duration(seconds: 1)).then((List<FilmInfo> infos){
      List<FilmInfo> infos= new List();
      infos.add(FilmInfo("Kodak", "Tmax400", 300, FilmType.thirtyFive));
      infos.add(FilmInfo("Ilford", "HP5", 300, FilmType.thirtyFive));
      infos.add(FilmInfo("Rollei", "Adox", 300, FilmType.thirtyFive));
      LoadingAnimAction action = LoadingAnimAction(infos, "error2", false);
    updateQueryAnim(action);
    });
  }
}
