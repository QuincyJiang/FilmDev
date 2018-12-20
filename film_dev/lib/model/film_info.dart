class FilmInfo{
  String brand;
  String name;
  int iso;
  int type;
}
class FilmBrand{
  static final String kodak = "Kodak";
  static final String ilford = "Ilford";
  static final String rollei = "Rollei";
  static final String fuji = "Fuji";
  static final String foma = "Foma";
  static final String kentmere = "Kentmere";
  static final String shanghai = "Shanghai";
  static final String gongyuan = "Gongyuan";
  static final String lucky = "Lucky";
  static final String agfa = "Agfa";
  static final List<String> brands = [kodak,ilford,agfa,fuji,foma,kentmere,rollei,shanghai,gongyuan,lucky];
}
class FilmType{
  static final int thirtyFive = 0;
  static final int oneTwenty = 1;
  static final int sheet = 2;
  static final List<String> types = ["35mm","120mm","散页片"];
}

class FilmIso{
  static final double iso2 = 2;
  static final double iso4 = 4;
  static final double iso6 = 6;
  static final double iso8 = 8;
  static final double iso12 = 12;
  static final double iso13 = 13;
  static final double iso14 = 14;
  static final double iso15 = 15;
  static final double iso16 = 16;
  static final double iso20 = 20;
  static final double iso25 = 25;
  static final double iso32 = 32;
  static final double iso40 = 40;
  static final double iso50 = 50;
  static final double iso64 = 64;
  static final double iso65 = 65;
  static final double iso75 = 75;
  static final double iso80 = 80;
  static final double iso100 = 100;
  static final double iso125 = 125;
  static final double iso130 = 130;
  static final double iso140 = 140;
  static final double iso150 = 150;
  static final double iso160 = 160;
  static final double iso200 = 200;
  static final double iso240 = 240;
  static final double iso250 = 250;
  static final double iso320 = 320;
  static final double iso400 = 400;
  static final double iso500 = 500;
  static final double iso600 = 600;
  static final double iso640 = 640;
  static final double iso650 = 650;
  static final double iso800 = 800;
  static final double iso1000 = 1000;
  static final double iso1200 = 1200;
  static final double iso1250 = 1250;
  static final double iso1280 = 1280;
  static final double iso1600 = 1600;
  static final double iso2000 = 2000;
  static final double iso2400 = 2400;
  static final double iso3200 = 3200;
  static final double iso4000 = 4000;
  static final double iso4800 = 4800;
  static final double iso5000 = 5000;
  static final double iso6400 = 6400;
  static final double iso6500 = 6500;
  static final double iso8000 = 8000;
  static final double iso12500 = 12500;
  static final double iso12800 = 12800;
  static final List<double> iso = [iso2,iso4,iso6,iso8,iso12,iso13,iso14,iso15,iso16,iso20,iso25,iso32,iso40,iso50,iso64,iso65,iso75,iso80,iso100,iso125,iso130,iso140,iso150,iso160,iso200,iso240,iso250,iso320,iso400,iso500,iso600,iso640,iso650,iso800,iso1000,iso1200,iso1250,iso1280,iso1600,iso2000,iso2400,iso3200,iso4000,iso4800,iso5000,iso6400,iso6500,iso8000,iso12500,iso12800];

}

