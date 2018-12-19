import 'package:flutter/material.dart';

@visibleForTesting
enum Location {
  Barbados,
  Bahamas,
  Bermuda
}

typedef ConfigItemBodyBuilder<T> = Widget Function(ConfigItem<T> item);
typedef ValueToString<T> = String Function(T value);

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint
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
    this.onSave,
    this.onCancel
  });

  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Column(
        children: <Widget>[
          Container(
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
          const Divider(height: 1.0),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: FlatButton(
                            onPressed: onCancel,
                            child: const Text('CANCEL', style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500
                            ))
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: FlatButton(
                            onPressed: onSave,
                            textTheme: ButtonTextTheme.accent,
                            child: const Text('SAVE')
                        )
                    )
                  ]
              )
          )
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

    _configItems = <ConfigItem<dynamic>>[
      ConfigItem<String>(
        name: 'Brand/品牌',
        value: 'Kodak',
        hint: 'kodak',
        valueToString: (String value) => value,
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
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  onSave: () { Form.of(context).save(); close(); },
                  onCancel: () { Form.of(context).reset(); close(); },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: item.textController,
                      decoration: InputDecoration(
                        hintText: item.hint,
                        labelText: item.name,
                      ),
                      onSaved: (String value) { item.value = value; },
                    ),
                  ),
                );
              },
            ),
          );
        },
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
                        onSave: () { Form.of(context).save(); close(); },
                        onCancel: () { Form.of(context).reset(); close(); },
                        child: FormField<String>(
                            initialValue: item.value,
                            onSaved: (String result) { item.value = result; },
                            builder: (FormFieldState<String> field) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RadioListTile<String>(
                                      value: "Tmax 100",
                                      title: const Text('Tmax 100'),
                                      groupValue: field.value,
                                      onChanged: field.didChange,
                                    ),
                                    RadioListTile<String>(
                                      value: "Tmax 200",
                                      title: const Text('Tmax 200'),
                                      groupValue: field.value,
                                      onChanged: field.didChange,
                                    ),
                                    RadioListTile<String>(
                                      value: "Tmax 400",
                                      title: const Text('Tmax 400'),
                                      groupValue: field.value,
                                      onChanged: field.didChange,
                                    ),
                                  ]
                              );
                            }
                        ),
                      );
                    }
                )
            );
          }
      ),
      ConfigItem<double>(
          name: 'ISO',
          value: 100,
          hint: '滑动滑块选择ISO',
          valueToString: (double amount) => '${amount.round()}',
          builder: (ConfigItem<double> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }

            return Form(
                child: Builder(
                    builder: (BuildContext context) {
                      return CollapsibleBody(
                        onSave: () { Form.of(context).save(); close(); },
                        onCancel: () { Form.of(context).reset(); close(); },
                        child: FormField<double>(
                          initialValue: item.value,
                          onSaved: (double value) { item.value = value; },
                          builder: (FormFieldState<double> field) {
                            return Slider(
                              min: 0,
                              max: 6400,
                              divisions: 50,
                              activeColor: Colors.orange[100 + (field.value * 5.0).round()],
                              label: '${field.value.round()}',
                              value: field.value,
                              onChanged: field.didChange,
                            );
                          },
                        ),
                      );
                    }
                )
            );
          }
      )
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
            child: ExpansionPanelList(
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
          ),
        ),
      ),
    );
  }
}