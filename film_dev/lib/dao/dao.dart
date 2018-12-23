import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';


// Db操作辅助类 初始化的时候 将assets中的devData.db 以及 fav.db 拷贝到项目文件目录下 使用单例实现

class DbManager {

  factory DbManager() => _getInstance();
  static DbManager get instance => _getInstance();
  static DbManager _instance;

  DbManager._internal();

  static DbManager _getInstance() {
    if (_instance == null) {
      _instance = new DbManager._internal();
    }
    return _instance;
  }

  String devDataPath;
  String favDataPath;

/* 数据库路径*/
  Future<String> get _devDbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "devData.db");
    return path;
  }

  Future<String> get _favDbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favData.db");
    return path;
  }

  void initDb() {
    /*拷贝asset中的数据库文件到app目录下*/
    Future<ByteData> devDbTmp = rootBundle.load("assets/devData.db");
    Future<ByteData> favDbTmp = rootBundle.load("assets/favData.db");
    _devDbPath.then((String dataPath) {
      _favDbPath.then((String favPath) {
        copyDb(dataPath, favPath, devDbTmp, favDbTmp);
      });
    });
  }

  void copyDb(String dataPath, String favPath, Future<ByteData> devData, Future<ByteData> favData) {
    File devDb = new File(dataPath);
    File favDb = new File(favPath);
    devDb.exists().then((bool exist) {
      if (!exist) {
        devData.then((ByteData data) {
          writeToFile(data, devDb);
        }); /* 拷贝dev数据库到本地文件*/
      }
    });
    favDb.exists().then((bool exist) {
      if (!exist) {
        favData.then((ByteData data) {
          writeToFile(data, favDb);
        }); /* 拷贝fav数据库到本地*/
      }
    });
  }

  Future<void> writeToFile(ByteData data, File file) {
    final buffer = data.buffer;
    return file.writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<Database> get _localDevDb async {
    final path = await _devDbPath;
    Database database = await openDatabase(path, version: 1);
    return database;
  }

  Future<Database> get _localFavDb async {
    final path = await _favDbPath;
    Database database = await openDatabase(path, version: 1);
    return database;
  }

  Future<List<String>> get _filmBrand {
    Future db = _localDevDb;
    //todo: 查询film品牌 返回list
  }

  Future<int> save(String name) async {
    final db = await _localDevDb;
    return db.transaction((trx) {
      trx.rawInsert('INSERT INTO user(name) VALUES("$name")');
    });
  }

  Future<List<Map>> getFilmInfo(FilmInfo queryInfo) async {
    final db = await _localDevDb;
    String brand = queryInfo.brand;
    int iso = queryInfo.iso.round();
    int type = 0;
    switch(queryInfo.type){
      case FilmType.thirtyFive:
        type = 0;
        break;
      case FilmType.oneTwenty:
        type = 1;
        break;
      case FilmType.sheet:
        type = 2;
        break;
    }
    return db.rawQuery("Select * from ZFILM where ZFILMTYPE = ${type} AND ZFILMBRAND = '${brand}' AND ZFILMISO = ${iso}");
  }

  Future<List<Map>> getDevInfo(FilmInfo queryInfo) async {
    final db = await _localDevDb;
    int filmId = queryInfo.id;
    await Future<int>.delayed(Duration(seconds: 1,milliseconds: 500 ));
    return db.rawQuery("Select * from ZDEVELOPER where ZFILM = ${filmId} ORDER BY ZDEVELOPERNAME");
  }

}

