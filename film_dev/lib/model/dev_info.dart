class DevInfo{
  String medicName;
  String dilution;
  String filmName;
  int filmId;
  int devId;

  DevInfo(this.medicName, this.dilution, this.filmName, this.filmId,
      this.devId);

  DevInfo.empty(){
    medicName = "Adox";
    dilution = "2:10";
    filmId = 0;
    devId = 0;
  }
  static String getIlution(String ilution){
    if(ilution.contains("stock")){
      return ilution.replaceAll('stock', "工作液/");
    }
    return "浓缩液/"+"稀释比 "+ilution.replaceAll("+", ":");
  }
  DevInfo.fromMap(Map<String, dynamic> map):medicName = map['ZDEVELOPERNAME'], dilution = getIlution(map['ZDEVELOPERDILUTION']), devId = map['_id'];
}



class DevInfoAnimAction{
  List<DevInfo> data;
  String anim;
  bool loading;

  DevInfoAnimAction(this.data, this.anim, this.loading);
  DevInfoAnimAction.empty(){
    data = new List();
    anim = "idle";
    loading = true;
  }
}