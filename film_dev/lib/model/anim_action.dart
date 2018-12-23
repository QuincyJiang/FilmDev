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