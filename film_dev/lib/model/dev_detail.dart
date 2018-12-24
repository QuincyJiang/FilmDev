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
  
  DevDetails(this.devDetailId,this.iso,this.devTimeA,this.devTimeB,this.medic,this.note);

  DevDetails.empty(){
    iso = "100";
    devDetailId = 0;
    devTimeB = 0;
    devTimeA = 0;
    medic = null;
    filmId = 0;
    temper = 0;
    note = "";
  }

  DevDetails.fromMap(Map<String, dynamic> map):
        devTimeA=map['ZDEVELOPMENTTIMEA'],
        devTimeB=map["ZDEVELOPMENTTIMEB"],
        iso=map["ZISO"],
        devDetailId=map["_id"],
        filmId=map["ZFILM"],
        temper=map["ZDEVELOPMENTTEMPERATURE"],
        note=map["ZDEVELOPMENTNOTESLONG"];
}