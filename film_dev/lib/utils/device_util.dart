import 'package:flutter/services.dart';

class DeviceUtil {
  factory DeviceUtil() =>_getInstance();
  static DeviceUtil get instance => _getInstance();
  static DeviceUtil _instance;
  DeviceUtil._internal();
  static DeviceUtil _getInstance() {
    if (_instance == null) {
      _instance = new DeviceUtil._internal();
    }
    return _instance;
  }
  void enterFullScreen(){
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  void exitFullScreen(){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
   // 把状态栏显示出来，需要一起调用底部虚拟按键（华为系列某些手机有虚拟按键）
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }
}