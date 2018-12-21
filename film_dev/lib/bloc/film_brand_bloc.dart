import 'dart:async';
import 'package:film_dev/dao/dao.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/providers/bloc_provider.dart';

class FilmInfoBloc implements BlocBase{
  FilmInfo _filmInfo;
  StreamController<FilmInfo> _filmInfoController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get _inFilmInfo => _filmInfoController.sink;
  Stream<FilmInfo> get outFilmInfo => _filmInfoController.stream;

  StreamController<FilmInfo> _changedFilmInfoController = StreamController<FilmInfo>.broadcast();
  Sink<FilmInfo> get updateFilmInfo => _changedFilmInfoController.sink;
  FilmInfoBloc(){
    _changedFilmInfoController.stream.listen(changeBrand);
  }
  void dispose() {
    _filmInfoController.close();
    _changedFilmInfoController.close();
  }
  void changeBrand(FilmInfo info){
    _filmInfo = info;
    _inFilmInfo.add(_filmInfo);
  }
  void queryFilmInfo(FilmInfo info){
    DbManager.instance.getFilmInfo(info).then((List<FilmInfo> films){

    });
  }
}
