class FilmInfo {
  String brand;
  String name;
  int iso;
  String type;
  int id;

  FilmInfo(this.brand, this.name, this.iso, this.type,this.id);
  String toString(){
    return "${brand} ${name} / ISO: ${iso} Type: ${type}";
  }
  FilmInfo.empty(){
    this.brand = FilmBrand.kodak;
    this.name = "";
    this.iso = FilmIso.iso100;
    this.type = FilmType.thirtyFive;
    this.id = 0;
  }
  FilmInfo.fromMap(Map<String, dynamic> map):brand = map['ZFILMBRAND'], name = map['ZFILMNAME'], iso = map['ZFILMISO'],type = getType(map["ZFILMTYPE"]),id = map['_id'];

  static String getType(int type){
    switch(type){
      case 0:
        return FilmType.thirtyFive;
        break;
      case 1:
        return FilmType.oneTwenty;
        break;
      case 2:
        return FilmType.sheet;
        break;
    }
    return FilmType.thirtyFive;
  }
}

class FilmBrand{
  static final String kodak = "Kodak";
  static final String ilford = "Ilford";
  static final String rollei = "Rollei";
  static final String fuji = "Fuji";
  static final String foma = "Foma";
  static final String kentmere = "Kentmere";
  static final String shanghai = "Shanghai";
  static final String lucky = "Lucky";
  static final String agfa = "Agfa";
  static final String adox = "Adox";
  static final List<String> brands = [kodak,ilford,agfa,adox,fuji,foma,kentmere,rollei,shanghai,lucky];
}
class FilmType{
  static const  String thirtyFive = "35mm";
  static const String oneTwenty = "120mm";
  static const String sheet = "Sheet";
  static final List<String> types = ["35mm","120mm","Sheet"];
}

class FilmIso{
  static final int iso2 = 2;
  static final int iso4 = 4;
  static final int iso6 = 6;
  static final int iso8 = 8;
  static final int iso12 = 12;
  static final int iso13 = 13;
  static final int iso14 = 14;
  static final int iso15 = 15;
  static final int iso16 = 16;
  static final int iso20 = 20;
  static final int iso25 = 25;
  static final int iso32 = 32;
  static final int iso40 = 40;
  static final int iso50 = 50;
  static final int iso64 = 64;
  static final int iso65 = 65;
  static final int iso75 = 75;
  static final int iso80 = 80;
  static final int iso100 = 100;
  static final int iso125 = 125;
  static final int iso130 = 130;
  static final int iso140 = 140;
  static final int iso150 = 150;
  static final int iso160 = 160;
  static final int iso200 = 200;
  static final int iso240 = 240;
  static final int iso250 = 250;
  static final int iso320 = 320;
  static final int iso400 = 400;
  static final int iso500 = 500;
  static final int iso600 = 600;
  static final int iso640 = 640;
  static final int iso650 = 650;
  static final int iso800 = 800;
  static final int iso1000 = 1000;
  static final int iso1200 = 1200;
  static final int iso1250 = 1250;
  static final int iso1280 = 1280;
  static final int iso1600 = 1600;
  static final int iso2000 = 2000;
  static final int iso2400 = 2400;
  static final int iso3200 = 3200;
  static final int iso4000 = 4000;
  static final int iso4800 = 4800;
  static final int iso5000 = 5000;
  static final int iso6400 = 6400;
  static final int iso6500 = 6500;
  static final int iso8000 = 8000;
  static final int iso12500 = 12500;
  static final int iso12800 = 12800;
  static final List<int> iso = [iso2,iso4,iso6,iso8,iso12,iso13,iso14,iso15,iso16,iso20,iso25,iso32,iso40,iso50,iso64,iso65,iso75,iso80,iso100,iso125,iso130,iso140,iso150,iso160,iso200,iso240,iso250,iso320,iso400,iso500,iso600,iso640,iso650,iso800,iso1000,iso1200,iso1250,iso1280,iso1600,iso2000,iso2400,iso3200,iso4000,iso4800,iso5000,iso6400,iso6500,iso8000,iso12500,iso12800];

}

