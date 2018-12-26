import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
    child: SafeArea(
    top: false,
    bottom: false,
    child: Card(
      elevation: 1,
    margin: const EdgeInsets.fromLTRB(24,20,24.0,10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0),
            topRight: Radius.circular(2.0),
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0),
          ),
        ),
    child: Column(
    children: <Widget>[
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('如何使用'),
            subtitle: Text("\n在首页查找胶片型号，点击后选择冲洗药水，设定目标ISO，即可查询出对应的显影时间。"),
          ),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxHeight: 1),
        decoration: BoxDecoration(color: Colors.grey[700]),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('状态指示 : 加载中'),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/loading.png'),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxHeight: 1),
        decoration: BoxDecoration(color: Colors.grey[700]),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('状态指示：无数据'),
            subtitle: Text("单击进度条会尝试重新加载。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/empty.png'),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxHeight: 1),
        decoration: BoxDecoration(color: Colors.grey[700]),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('使用药水配比计算器'),
            subtitle: Text("在【冲洗配置】-【配比】栏目点击，输入要配制的工作液体积，即可自动计算浓缩液和纯净水的用量。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/configVol.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('切换至暗房模式'),
            subtitle: Text("在【开始冲洗】中，点击上方灯泡即可切换至暗房模式。"
                "\n注意：暗房模式会尽可能调低屏幕亮度，但是仍不能保证完全不对您的底片造成干扰，在暗房中务必将手机放置在离您的冲洗盘至少一米开外的距离上。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/darkMode.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('自定义你的停显、定影、去海波时间'),
            subtitle: Text("在【开始冲洗】-【停显】条目点击，输入停显时间，计时器会自动更新时间。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/configDevTime.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('计时器的使用'),
            subtitle: Text("单击，可在开始与暂停计时之间切换，长按则重置计时器。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/timer.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('使用收藏夹'),
            subtitle: Text("在【开始冲洗】最下方，可以将你目前的冲洗配置加入收藏夹。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/addFav.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('查看收藏夹'),
            subtitle: Text("右滑出菜单，即可查看收藏夹。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/favPage.png'),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child: ListTile(
            dense: false,
            title: Text('删除收藏'),
            subtitle: Text("长按收藏条目即可删除收藏。"),
          ),
        ),
      ),
      Center(
        child: Padding(padding:EdgeInsets.all(10),
          child:Image.asset('assets/deleteFav.png'),
        ),
      ),
    ],))))
    );
  }
}
