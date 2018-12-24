import 'package:film_dev/model/film_info.dart';

class DevInfo{
  String medicName;
  String dilution;
  int filmId;
  int devId;
  FilmInfo filmInfo;
  double totalVolume = 500;
  double waterVolume;
  double medicVolume;
  double diluNum;
  bool concentrate;

  DevInfo(this.medicName, this.dilution, this.filmId,
      this.devId,this.filmInfo,this.medicVolume,this.waterVolume,this.totalVolume,this.concentrate);
String toString(){
  return "${medicName} ${dilution} ";
}
  DevInfo.empty(){
    medicName = "Adox";
    dilution = "2:10";
    filmId = 0;
    devId = 0;
    filmInfo = null;
    waterVolume = 0;
    totalVolume = 500;
    medicVolume =1;
    diluNum = 5;
    concentrate = false;
  }
  static String getIlution(String dilution){
    if(dilution.contains("stock")){
      return dilution.replaceAll('stock', "");
    }
    return dilution.replaceAll("+", ":");
  }

  static double getDiluNum(String raw){
    if(isConcentrate(raw)){
      String dilution = getIlution(raw);
      List<String> prop = dilution.split(":");
      try{
        int medicProp = int.parse(prop[0]);
        int totalProp = int.parse(prop[1]);
        return totalProp/medicProp;
      }catch(e){
        return 1;
      }
    }
    else {
      return 1;
    }
  }

  static double getWaterVolume(String dilution){
    double prop = getDiluNum(dilution);
    return 500*prop/(prop+1);
  }
  static double getMedicVolume(String dilution){
    double prop = getDiluNum(dilution);
    return 500/(prop+1);
  }

  static bool isConcentrate(String dilution){
    return !dilution.contains("stock");
  }

  static String getDevName(String name,String dilution){
    if(isConcentrate(dilution)){
      return name+" 浓缩液";
    }else return name+" 工作液";
  }
  DevInfo.fromMap(Map<String, dynamic> map):
        medicName = getDevName( map['ZDEVELOPERNAME'],map['ZDEVELOPERDILUTION']),
        dilution = getIlution(map['ZDEVELOPERDILUTION']),
        diluNum = getDiluNum(map['ZDEVELOPERDILUTION']),
        concentrate = isConcentrate(map['ZDEVELOPERDILUTION']),
        waterVolume = getWaterVolume(map['ZDEVELOPERDILUTION']),
        medicVolume = getMedicVolume(map['ZDEVELOPERDILUTION']),
        devId = map['_id'];
}
