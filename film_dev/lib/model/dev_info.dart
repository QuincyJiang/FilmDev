import 'package:film_dev/model/film_info.dart';

class DevInfo{
  String medicName;
  String dilution;
  int filmId;
  int devId;
  FilmInfo filmInfo;

  DevInfo(this.medicName, this.dilution, this.filmId,
      this.devId,this.filmInfo);
String toString(){
  return "${medicName} ${dilution} ";
}
  DevInfo.empty(){
    medicName = "Adox";
    dilution = "2:10";
    filmId = 0;
    devId = 0;
    filmInfo = null;
  }
  static String getIlution(String ilution){
    if(ilution.contains("stock")){
      return ilution.replaceAll('stock', "工作液");
    }
    return "浓缩液 "+ilution.replaceAll("+", ":")+"稀释";
  }
  DevInfo.fromMap(Map<String, dynamic> map):medicName = map['ZDEVELOPERNAME'], dilution = getIlution(map['ZDEVELOPERDILUTION']), devId = map['_id'];
}
