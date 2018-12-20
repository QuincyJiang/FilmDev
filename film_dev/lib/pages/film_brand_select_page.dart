import 'package:film_dev/model/film_info.dart';
import 'package:flutter/material.dart';

@visibleForTesting

typedef ConfigItemBodyBuilder<T> = Widget Function(ConfigItem<T> item);
typedef ValueToString<T> = String Function(T value);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint,
  });
  final String name;
  final String value;
  final String hint;
  final bool showHint;
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
    return Row(
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
                      Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
                      showHint
                  )
              )
          )
        ]
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
    this.valueToString
  }) : textController = TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final ConfigItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          showHint: isExpanded
      );
    };
  }

  Widget build() => builder(this);
}

class FilmBrandSelectPage extends StatefulWidget {

  @override
  _FilmBrandSelectPageState createState() => _FilmBrandSelectPageState();
}

class _FilmBrandSelectPageState extends State<FilmBrandSelectPage> {
  List<ConfigItem<dynamic>> _configItems;

  @override
  void initState() {
    super.initState();
    List<String> brands = FilmBrand.brands;
    List<String> types = ["彩色负片","彩色正片","黑白负片"];
    List<String> model = ["Tmax100","Tmax200","Tmax400"];
    _configItems = <ConfigItem<dynamic>>[
      ConfigItem<String>(
          name: 'Brand/品牌',
          value: "Kodak",
          hint: 'Kodak',
          valueToString: (String model) => model,
          builder: (ConfigItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: FormField<String>(
                            initialValue: item.value,
                            onSaved: (String result) { item.value = result; },
                            builder: (FormFieldState<String> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: buildItemChildren(context,field, brands)
                              );
                            }
                        ),
                      );
                    }
                )
            );
          }
      ),
      ConfigItem<String>(
          name: 'Type/类型',
          value: "彩色负片",
          hint: '彩色负片',
          valueToString: (String model) => model,
          builder: (ConfigItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: FormField<String>(
                            initialValue: item.value,
                            onSaved: (String result) { item.value = result; },
                            builder: (FormFieldState<String> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: buildItemChildren(context,field, types)
                              );
                            }
                        ),
                      );
                    }
                )
            );
          }
      ),
      ConfigItem<String>(
          name: 'Model/型号',
          value: "Tmax 100",
          hint: 'Tmax 100',
          valueToString: (String model) => model,
          builder: (ConfigItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }
            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        child: FormField<String>(
                            initialValue: item.value,
                            onSaved: (String result) { item.value = result; },
                            builder: (FormFieldState<String> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: buildItemChildren(context,field, model)
                              );
                            }
                        ),
                      );
                    }
                )
            );
          }
      ),
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
            margin: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _configItems[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _configItems.map<ExpansionPanel>((ConfigItem<dynamic> item) {
                      return ExpansionPanel(
                          isExpanded: item.isExpanded,
                          headerBuilder: item.headerBuilder,
                          body: item.build()
                      );
                    }).toList()
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: RaisedButton(
                    onPressed: toSelectResultPage(context),
                textColor: Colors.white,
                child: Text("选好了"),),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

 toSelectResultPage(BuildContext context){
//  Navigator.of(context).pushReplacement(new MaterialPageRoute(
//      builder: (BuildContext context) => widget));
}


List<Widget> buildItemChildren(BuildContext context,FormFieldState<String> field,
    List<String> data) {
  List<Widget> widgets = new List();
  if (data != null) data.forEach((data) =>
      widgets.add(RadioListTile<String>(
        value: data,
        title: Text(data),
        groupValue: field.value,
        onChanged: (String value){
          field.didChange(value);
          Form.of(context).save();
        },
        activeColor: Colors.yellow[800],)));
  return widgets;
}