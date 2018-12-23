import 'package:film_dev/bloc/film_brand_bloc.dart';
import 'package:film_dev/model/anim_action.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/dev_medic_select_page.dart';
import 'package:film_dev/providers/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flare_flutter/flare_actor.dart';

typedef ConfigItemBodyBuilder<T> = Widget Function(ConfigItem<T> item);
typedef ValueToString<T> = String Function(T value);

class FilmSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocProvider(
        bloc: FilmInfoBloc(),
        child:BlocFilmSelectPage(),
      ),
    );
  }
}

// 表单标题
class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint,
    this.hintClickedCallback,
    this.index,
  });
  final String name;
  final String value;
  final String hint;
  final bool showHint;
  final int index;
  final HintCallback hintClickedCallback;
  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
  @override
  Widget build(BuildContext context) {
    final FilmInfoBloc infoBloc = BlocProvider.of<FilmInfoBloc>(context);
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return  GestureDetector(
        child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: textTheme.body1.copyWith(fontSize: 15.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                      margin: const EdgeInsets.only(left: 24.0),
                      child: _crossFade(
                          StreamBuilder<FilmInfo>(
                            // 使用bloc模式做到表单标题和表单内容的联动
                            stream: infoBloc.outTitleHint,
                            initialData: FilmInfo.empty(),
                            builder: (BuildContext context,AsyncSnapshot<FilmInfo> snapshot){
                              switch(index){
                                case 0:
                                  return Text("${snapshot.data.brand}", style: textTheme.caption.copyWith(fontSize: 15.0));
                                case 1:
                                  return Text("${snapshot.data.type}", style: textTheme.caption.copyWith(fontSize: 15.0));
                                case 2:
                                  return Text("${snapshot.data.iso}", style: textTheme.caption.copyWith(fontSize: 15.0));
                              }
                            }),
                          StreamBuilder<FilmInfo>(
                              stream: infoBloc.outTitleHint,
                              initialData: FilmInfo.empty(),
                              builder: (BuildContext context,AsyncSnapshot<FilmInfo> snapshot){
                                switch(index){
                                  case 0:
                                    return Text("${snapshot.data.brand}", style: textTheme.caption.copyWith(fontSize: 15.0));
                                  case 1:
                                    return Text("${snapshot.data.type}", style: textTheme.caption.copyWith(fontSize: 15.0));
                                  case 2:
                                    return Text("${snapshot.data.iso}", style: textTheme.caption.copyWith(fontSize: 15.0));
                                }
                              }),
                         showHint
                      )
                  )
              )
            ]
        ),
        onTap: (){
          if(hintClickedCallback!=null){
            hintClickedCallback();
          }
        }
    );
  }
}

// 表单内容
class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody({
    this.margin = EdgeInsets.zero,
    this.child,
  });

  final EdgeInsets margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
            ),
              margin: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0
              ) - margin,
              child: Center(
                  child: DefaultTextStyle(
                      style: textTheme.caption.copyWith(fontSize: 15.0),
                      child: child
                  )
              )
          ),
        ]
    );
  }
}

class ConfigItem<T> {
  ConfigItem({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString,
    this.onHintClicked,
    this.index,
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  String hint;
  final TextEditingController textController;
  final ConfigItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  HintCallback onHintClicked;
  final index;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          index: index,
          hintClickedCallback: onHintClicked,
          showHint: isExpanded
      );
    };
  }

  Widget build() => builder(this);
}

class BlocFilmSelectPage extends StatefulWidget {
  @override
  _BlocFilmSelectPageState createState() => _BlocFilmSelectPageState();
}

class _BlocFilmSelectPageState extends State<BlocFilmSelectPage> {
  FilmInfo info;
  List<ConfigItem<dynamic>> _configItems;
  List<bool> expandedConfig = [false,false,false];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //初始化表单的数据
  @override void initState() {
    super.initState();
    info = FilmInfo.empty();
    _configItems = <ConfigItem<dynamic>>[
      ConfigItem<String>(name: 'Brand/品牌',
          value: "Kodak",
          hint: 'Kodak',
          index: 0,
          onHintClicked: () {
            setState(() {
              expandedConfig[0] = !expandedConfig[0];
            });
          },
          valueToString: (String model) => model,
          builder: (ConfigItem<String> item) {
            return Form(child: Builder(builder: (BuildContext context) {
              return CollapsibleBody(child: FormField<String>(
                  initialValue: item.value, onSaved: (String result) {
                item.value = result;
              }, builder: (FormFieldState<String> field) {
                return Column(mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildItemChildren(context, field, FilmBrand.brands));
              }),);
            }));
          }),
      ConfigItem<String>(name: 'Format/片幅',
          value: "35mm",
          hint: '35mm',
          index: 1,
          onHintClicked: () {
            setState(() {
              expandedConfig[1] = !expandedConfig[1];
            });
          },
          valueToString: (String model) => model,
          builder: (ConfigItem<String> item) {
            return Form(child: Builder(builder: (BuildContext context) {
              return CollapsibleBody(child: FormField<String>(
                  initialValue: item.value, onSaved: (String result) {
                item.value = result;
              }, builder: (FormFieldState<String> field) {
                return Column(mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildItemChildren(context, field, FilmType.types));
              }),);
            }));
          }),
      ConfigItem<double>(name: 'ISO',
          value: 100,
          hint: '滑动滑块选择ISO',
          index: 2,
          onHintClicked: () {
            setState(() {
              expandedConfig[2] = !expandedConfig[2];
            });
          },
          valueToString: (double amount) => '${amount.round()}',
          builder: (ConfigItem<double> item) {
            return Form(child: Builder(builder: (BuildContext context) {
              return CollapsibleBody(child: FormField<double>(
                initialValue: item.value, onSaved: (double value) {
                item.value = value;
              }, builder: (FormFieldState<double> field) {
                return Padding(padding: EdgeInsets.fromLTRB(0.0, 50, 0.0, 0.0),
                    child: new SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.yellow[800],
                        inactiveTrackColor: Colors.black,
                        disabledActiveTrackColor: Colors.white,
                        activeTickMarkColor: Colors.yellow,
                        thumbColor: Colors.white,
                        overlayColor: Colors.transparent,
                        valueIndicatorColor: Colors.yellow[800],),
                      child: Slider(
                        min: 32,
                        max: 800,
                        divisions: 300,
                        activeColor: Colors.orange[100 +
                            (field.value * 5.0).round()],
                        label: '${field.value.round()}',
                        value: field.value,
                        onChanged: (double value) {
                          field.didChange(processISO(context,value, FilmIso.iso));
                          Form.of(context).save();
                        },),));
              },),);
            }));
          })
    ];
  }

  // 主页面
  @override
  Widget build(BuildContext context) {
    final FilmInfoBloc infoBloc = BlocProvider.of<FilmInfoBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            margin: const EdgeInsets.fromLTRB(24,0,24.0,10),
            child: Column(
              children: <Widget>[
                Container(
                  child: new FlareActor("assets/rotate.flr",
                      alignment:Alignment.center,
                      fit:BoxFit.contain,
                      animation:"enter"),
                  constraints:  BoxConstraints.expand(height: 150),
                ),
                Card(
                    elevation: 1,
                    margin: EdgeInsets.fromLTRB(0,10,0,10),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        topRight: Radius.circular(2.0),
                        bottomLeft: Radius.circular(2.0),
                        bottomRight: Radius.circular(2.0),
                      ),
                    ),
                    child:Center(
                      child: Padding(padding:EdgeInsets.all(10),
                        child: Text("Select Film",
                          style: TextStyle(
                              fontSize: Theme.of(context).textTheme.subhead.fontSize
                          ),),
                      ),
                    )
                ),
                ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        expandedConfig[index] = !isExpanded;
                      });
                    },
                    children: _configItems.map<ExpansionPanel>((ConfigItem<dynamic> item) {
                      return ExpansionPanel(
                          isExpanded: expandedConfig[_configItems.indexOf(item)],
                          headerBuilder: item.headerBuilder,
                          body: item.build()
                      );
                    }).toList()
                ),
            StreamBuilder<LoadingAnimAction>(
                stream: infoBloc.outLoadingStatus,
                initialData: LoadingAnimAction.empty(),
                builder: (BuildContext context,AsyncSnapshot<LoadingAnimAction> snapshot){
                  if(snapshot.data.loading){
                    return  buildLoadingView(infoBloc,snapshot);
                  }else{
                    return buildLoadingResultView(infoBloc, snapshot);
                  }
                }),
              ],
            )
          ),
        ),
      ),
    );
  }

  // 展示加载中的动画
  Widget buildLoadingView(FilmInfoBloc infoBloc,AsyncSnapshot<LoadingAnimAction> snapshot){
    return Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: GestureDetector(child: Container(child: new FlareActor(
          "assets/loading.flr", alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "${snapshot.data.anim}"),
        constraints: BoxConstraints.expand(height: 100),),
        onTap: () {
          infoBloc.queryFilmInfo(info);
        },),
    );
  }

  Widget buildEmptyPage(){
    return Container(width: 0,height: 0,);
  }
  // 展示查询结果
  Widget buildLoadingResultView(FilmInfoBloc infoBloc,AsyncSnapshot<LoadingAnimAction> snapshot){
    if(snapshot.data.data.length == 0){
      return buildEmptyPage();
    }
    return Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(0,10,0,20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0),
            topRight: Radius.circular(2.0),
            bottomLeft: Radius.circular(2.0),
            bottomRight: Radius.circular(2.0),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildFilmInfoList(context, snapshot.data.data))
    );
  }

// 根据传入的List<String> 构建折叠表单的条目
  List<Widget> buildItemChildren(BuildContext context,
      FormFieldState<String> field, List<String> data) {
    final FilmInfoBloc infoBloc = BlocProvider.of<FilmInfoBloc>(context);
    List<Widget> widgets = new List();
    if (data != null) data.forEach((data) =>
        widgets.add(RadioListTile<String>(
          value: data,
          title: Text(data),
          groupValue: field.value,
          onChanged: (String value) {
            field.didChange(value);
            Form.of(context).save();
            if(FilmType.types.contains(value)){
              info.type = value;
              infoBloc.updateFilmInfo.add(info);
            }else{
              info.brand = value;
              infoBloc.updateFilmInfo.add(info);
            }
            infoBloc.queryFilmInfo(info);
          },
          activeColor: Colors.yellow[800],)));
    return widgets;
  }
  // 构建查找结果条目
  List<Widget> buildFilmInfoList(BuildContext context, List<FilmInfo> datas) {
    List<Widget> widgets = new List();
    int i = 0;
    if (datas != null) datas.forEach((data){
        widgets.add(
            new Material(
              color: Colors.grey[800],
              child: new InkWell(
                onTap: (){
                  toSelectResultPage(data);
                },
                child:  MergeSemantics(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                      child: ListTile(
                        dense: false,
                        title: Text('${data.brand}  ${data.name}'),
                        subtitle: Text("Format: ${data.type} ISO: ${data.iso}"),
                      ),)
              ),
            )
        )
        );
        // 添加分割线
        if(i!= datas.length-1){
          widgets.add(Container(
            constraints: BoxConstraints(maxHeight: 1),
            decoration: BoxDecoration(color: Colors.grey[700]),
          ));
        }
    i++;
    }
    );
    return widgets;
  }

  // 去下一页
  toSelectResultPage(FilmInfo info) {
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevMedicSelectPage(info)));
  }

// 处理滑块选择的iso值 滑块选择的值是连续的 但是可用的iso只有一些特定值 对这些连续值做一下处理
  double processISO(BuildContext context,double raw,List<int> iso){
    int current = iso[0];
    final FilmInfoBloc infoBloc = BlocProvider.of<FilmInfoBloc>(context);
    iso.forEach((int iso){
      if((raw-iso).abs() < (raw-current).abs()){
        current = iso;
      }}
    );
    info.iso = current.round();
    infoBloc.updateFilmInfo.add(info);
    infoBloc.queryFilmInfo(info);
    return current.toDouble();
  }
}

// 表单标题点击的回调 为了做到点击标题也能折叠表单的效果
typedef HintCallback = void Function();





