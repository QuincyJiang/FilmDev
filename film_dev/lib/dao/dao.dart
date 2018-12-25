import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/fav_info.dart';
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


  Future<int> save(String name,DevDetails devDetails) async {
    final db = await _localFavDb;
    String insert = "INSERT INTO tblFavTimes "
        "(favName,filmName,filmISO,filmType,devName,devDilution,volTotal,volWater,volMedic,devTempInC,devTimeA,devTimeB,fixingTimeA,stopBathTime,hypoClearTime,washTime,"
        "filmId,devId,filmBrand,concentrate,devDetailId,pushedISO,notesBody,dilutionNum) VALUES "
        "('${name}','${devDetails.medic.filmInfo.name}','${devDetails.medic.filmInfo.iso}','${devDetails.medic.filmInfo.type}','${devDetails.medic.medicName}'"
        ",'${devDetails.medic.dilution}','${devDetails.medic.totalVolume}','${devDetails.medic.waterVolume}','${devDetails.medic.medicVolume}'"
        ",'${devDetails.temper}','${devDetails.devTimeA}','${devDetails.devTimeB}','${devDetails.fixTime}','${devDetails.stopTime}','${devDetails.hypoTime}','${devDetails.washTime}'"
        ",'${devDetails.medic.filmInfo.id}','${devDetails.medic.devId}','${devDetails.medic.filmInfo.brand}','${devDetails.medic.concentrate}','${devDetails.devDetailId}','${devDetails.iso}','${devDetails.note}','${devDetails.medic.diluNum}')";
    return db.rawInsert(insert);
  }
    Future<bool> isFavExist(String name) async{
    final db = await _localFavDb;
    String query = "select favName from tblFavTimes where favName='${name}'";
    List<Map> result = await db.rawQuery(query);
    if(result == null || result.length == 0)
      return false;
    else return true;
  }
   Future<int> getCollectionSize(String name) async{
    final db = await _localFavDb;
    String query = "select favName from tblFavTimes where favName='${name}'";
    List<Map> result = await db.rawQuery(query);
    return result.length;
  }
  Future<int> getDefaultNameLength(String name) async{
    final db = await _localFavDb;
    String query = "select favName from tblFavTimes where favName like '${name}%'";
    List<Map> result = await db.rawQuery(query);
    return result.length;
  }
  
  Future<List<FavInfo>> getFav() async{
    final db = await _localFavDb;
    String query = "select * from tblFavTimes";
    List<Map> resultList = await db.rawQuery(query);
    List<FavInfo> favResult = new List();
    try{
    resultList.forEach((result){
      FilmInfo filmInfo = new FilmInfo(result['filmBrand'],result['filmName'], result['filmISO'], result['filmType'], result['filmId']);
      DevInfo devInfo = new DevInfo(result['devName'], result['devDilution'], result['filmId'], result['devId'], filmInfo,result['volMedic'], result['volWater'], result['volTotal'], getBool(result['concentrate']),result['dilutionNum']);
      DevDetails details = new DevDetails(result['devDetailId'], result['pushedISO'], result['devTimeA'], result['devTimeB'], devInfo, result['filmId'], result['devTempInC'], result['notesBody'], result['fixingTimeA'], result['stopBathTime'], result['hypoClearTime'], result['washTime']);
      favResult.add(FavInfo(details, result['favName']));
    });}
    catch(e){
      print("parse db data failed! messag: "+e.toString());
    }
    return favResult;
  }

  bool getBool(dynamic value){
    return (value as String) == null?false:(value as String) == "true";
  }

  Future<int> deleteCollect(String name) async{
    final db = await _localFavDb;
    String delete = "delete from tblFavTimes where favName='${name}'";
    return db.rawDelete(delete);
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
    await Future<int>.delayed(Duration(milliseconds: 200));
    return db.rawQuery("Select * from ZFILM where ZFILMTYPE = ${type} AND ZFILMBRAND = '${brand}' AND ZFILMISO = ${iso}");
  }

  Future<List<Map>> getDevInfo(FilmInfo queryInfo) async {
    final db = await _localDevDb;
    int filmId = queryInfo.id;
    await Future<int>.delayed(Duration(milliseconds: 200));
    return await db.rawQuery("Select * from ZDEVELOPER where ZFILM = ${filmId} ORDER BY ZDEVELOPERNAME");
  }
  Future<List<Map>> getDevDetails(DevInfo queryInfo) async {
    final db = await _localDevDb;
    int devId = queryInfo.devId;
    await Future<int>.delayed(Duration(milliseconds: 200));
    return await db.rawQuery("select ZISO.ZISO,"
        "ZDEVELOPMENTTIME.ZDEVELOPMENTTIMEA,"
        "ZDEVELOPMENTTIME._id,"
        "ZDEVELOPMENTTIME.ZFILM,"
        "ZDEVELOPMENTTIME.ZDEVELOPMENTTIMEB,"
        "ZDEVELOPMENTTIME.ZDEVELOPMENTTEMPERATURE,"
        "ZDEVELOPMENTTIME.ZDEVELOPMENTNOTES,"
        "ZDEVELOPMENTTIME.ZDEVELOPMENTNOTESLONG "
        "from ZISO,ZDEVELOPMENTTIME where ZISO._id=ZDEVELOPMENTTIME.ZISO and ZDEVELOPMENTTIME.ZDEVELOPER=${devId}");
  }

}

