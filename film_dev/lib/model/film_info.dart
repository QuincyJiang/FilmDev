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
  static final int colorNegative = 0;
  static final int colorPositive = 1;
  static final int blackWhite = 2;
  static final List<int> types = [colorNegative,colorPositive,blackWhite];
}

