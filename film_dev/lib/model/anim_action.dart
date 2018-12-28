import 'dart:collection';

import 'package:film_dev/model/dev_detail.dart';
import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/fav_info.dart';
import 'package:film_dev/model/film_info.dart';

// 查询动画实体类
class LoadingAnimAction{
  List<FilmInfo> data;
  String anim;
  // bool loading ：
  // 为false时 根据data数据 展示查询结果  不显示动画
  // 为true时 根据anim的值 显示对应的动画效果 目前有 idle loading error error2 四种动画效果
  bool loading;
  LoadingAnimAction(this.data, this.anim,this.loading);
  LoadingAnimAction.empty(){
    this.data = new List();
    this.anim = "empty";
    this.loading = true;
  }
}

class DevInfoLoadingAnimAction{
  List<DevDetails> data;
  String anim;
  // bool loading ：
  // 为false时 根据data数据 展示查询结果  不显示动画
  // 为true时 根据anim的值 显示对应的动画效果 目前有 idle loading error error2 四种动画效果
  bool loading;
  DevInfoLoadingAnimAction(this.data, this.anim,this.loading);
  DevInfoLoadingAnimAction.empty(){
    this.data = new List();
    this.anim = "empty";
    this.loading = true;
  }
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
class FavInfoAnimAction{
  List<FavInfo> data;
  String anim;
  bool loading;

  FavInfoAnimAction(this.data, this.anim, this.loading);
  FavInfoAnimAction.empty(){
    data = new List();
    anim = "idle";
    loading = true;
  }
}


class FilmInfoListLoadingAnimAction{
  LinkedHashMap<String,List<FilmInfo>> data;
  String anim;
  bool loading;

  FilmInfoListLoadingAnimAction(this.data, this.anim, this.loading);
  FilmInfoListLoadingAnimAction.empty(){
    data = new LinkedHashMap();
    anim = "idle";
    loading = true;
  }

}