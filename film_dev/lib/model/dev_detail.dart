import 'package:film_dev/model/dev_info.dart';

class DevDetails{
  int devDetailId;
  String iso;
  int devTimeA;
  int devTimeB;
  DevInfo medic;
  int filmId;
  double temper;
  String note;
  int fixTime;
  int stopTime;
  int hypoTime;
  int washTime;

  DevDetails(this.devDetailId, this.iso, this.devTimeA, this.devTimeB,
      this.medic, this.filmId, this.temper, this.note, this.fixTime,
      this.stopTime, this.hypoTime, this.washTime);

  DevDetails.empty(){
    iso = "100";
    devDetailId = 0;
    devTimeB = 0;
    devTimeA = 0;
    medic = null;
    filmId = 0;
    temper = 0;
    note = "";
    fixTime = 300;
    stopTime = 60;
    hypoTime = 120;
    washTime = 600;
  }

  DevDetails.fromMap(Map<String, dynamic> map):
        devTimeA=map['ZDEVELOPMENTTIMEA'],
        devTimeB=map["ZDEVELOPMENTTIMEB"],
        iso=map["ZISO"],
        devDetailId=map["_id"],
        filmId=map["ZFILM"],
        temper=map["ZDEVELOPMENTTEMPERATURE"],
        fixTime = 300,
        stopTime = 60,
        hypoTime = 120,
        washTime = 600,
        note=map["ZDEVELOPMENTNOTESLONG"];
}