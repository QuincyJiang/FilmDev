import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
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
                          child: Padding(padding:EdgeInsets.fromLTRB(10,20,10,10),
                            child: Text("如果觉得本应用帮到了你"
                                "\n可以考虑给我买一杯咖啡  ",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                              ),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child:   Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(padding:EdgeInsets.all(10),
                                  child:Image.asset('assets/wechat.jpeg'),
                                ),
                              ),
                              Expanded(
                                child: Padding(padding:EdgeInsets.all(10),
                                  child:Image.asset('assets/alipay.jpeg'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        )


                      ],))))
    );
  }
}
