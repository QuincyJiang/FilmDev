import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonatePage extends StatelessWidget {
  static const platform = const MethodChannel('com.jiangxq.filmdev/menu');
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
                    child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.mood),
                              title: const Text('谢谢支持  ￥1'),
                              onTap: donate,
                            ),
                            ListTile(
                              leading: const Icon(Icons.local_drink),
                              title: const Text('一杯可乐  ￥3'),
                              onTap: donate,
                            ),
                            ListTile(
                              leading: const Icon(Icons.fastfood),
                              title: const Text('一份薯条  ￥5'),
                              onTap: donate,
                            ),
                            ListTile(
                              leading: const Icon(Icons.local_movies),
                              title: const Text('一卷胶卷  ￥10'),
                              onTap: donate,
                            ),
                            ListTile(
                              leading: const Icon(Icons.local_cafe),
                              title: const Text('一杯咖啡  ￥20'),
                              onTap: donate,
                            ),
                          ],
                        ),
                        )
                )
            )
    );
    }
    void donate(){
      platform.invokeMethod("donate");
    }
}
