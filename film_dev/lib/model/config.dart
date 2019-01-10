class Constant{
  static const int DEV_C41_COMMON = 0;
  static const int DEV_C41_ARISTA_LIQUID = 1;
  static const int DEV_C41_ROLLEI_DIGIBASE = 2;
  static const int DEV_C41_TETENAL_COLORTEC = 3;
  static const int DEV_C41_UNICOLOR_POWER = 4;
  static const int DEV_E6_COMMON = 5;
  static const int DEV_E6_ARISTA_RAPID = 6;
  static const int DEV_E6_FUJI_CHROME_6X = 7;
  static const int DEV_TETENAL_COLORTEC = 8;
  static const int DEV_ECN2_COMMON = 9;
}

class Process{
  int code;
  String name;
  List<ProcedureItem> procedure;
  Process(this.code, this.name,this.procedure);
}

class ProcedureItem{
  String procedureName;
  int devTime;
  String procedureDescription;

  ProcedureItem(this.procedureName, this.devTime, this.procedureDescription);
}
