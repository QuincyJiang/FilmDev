import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

String dbPath;
// 数据库路径
Future<String> get getDbPath async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "devData.db");
  return path;
}

void initDb(){
  //拷贝asset中的数据库文件到app目录下
  Future<ByteData> devDbTmp = rootBundle.load("assets/devData.db");
  getDbPath.then((String path){
   copyDb(path,devDbTmp);
  }
  );

  }

  void copyDb(String path,Future<ByteData> data) {
    File devDb = new File(path);
    devDb.exists().then((bool exist){
      if(!exist){
        //todo: copy db file
      }
    });

  }

