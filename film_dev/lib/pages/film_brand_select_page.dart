import 'package:film_dev/bloc/film_brand_bloc.dart';
import 'package:film_dev/model/film_info.dart';
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

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint,
    this.hintClickedCallback,
  });
  final String name;
  final String value;
  final String hint;
  final bool showHint;
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
                        Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
                        Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)), showHint
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
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  String hint;
  final TextEditingController textController;
  final ConfigItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  HintCallback onHintClicked;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
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
  List<ConfigItem<dynamic>> _configItems;
  List<bool> expandedConfig = [false,false,false];
  @override void initState() {
    super.initState();
    _configItems = <ConfigItem<dynamic>>[
      ConfigItem<String>(name: 'Brand/品牌',
          value: "Kodak",
          hint: 'Kodak',
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
                          field.didChange(processISO(value, FilmIso.iso));
                          Form.of(context).save();
                        },),));
              },),);
            }));
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0,0.0,0.0,20),
                  child: Container(
                    child: Text("选择胶片",
                      style: TextStyle(
                        color: Colors.yellow[900],
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: RaisedButton(
                    onPressed: toSelectResultPage(context),
                textColor: Colors.white,
                child: Padding(padding: EdgeInsets.all(10),
                    child: new Text(
                      "选好了",
                      style: new TextStyle(
                        color: Colors.white
                      ) ,),),
                ))
              ],
            )
          ),
        ),
      ),
    );
  }

// 根据传入的List<String> 构建折叠表单的条目
  List<Widget> buildItemChildren(BuildContext context,
      FormFieldState<String> field, List<String> data) {
    List<Widget> widgets = new List();
    if (data != null) data.forEach((data) =>
        widgets.add(RadioListTile<String>(
          value: data,
          title: Text(data),
          groupValue: field.value,
          onChanged: (String value) {
            field.didChange(value);
            Form.of(context).save();
          },
          activeColor: Colors.yellow[800],)));
    return widgets;
  }
  // 跳转到下一屏
  toSelectResultPage(BuildContext context){
//  Navigator.of(context).pushReplacement(new MaterialPageRoute(
//      builder: (BuildContext context) => widget));
  }

// 处理滑块选择的iso值 滑块选择的值是连续的 但是可用的iso只有一些特定值 对这些连续值做一下处理
  double processISO(double raw,List<double> iso){
    double current = iso[0];
    iso.forEach((double iso){
      if((raw-iso).abs() < (raw-current).abs()){
        current = iso;
      }}
    );
    return current;
  }
}

typedef HintCallback = void Function();



