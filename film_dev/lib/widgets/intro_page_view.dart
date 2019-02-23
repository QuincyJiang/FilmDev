import 'package:film_dev/pages/c41_select_page.dart';
import 'package:film_dev/pages/film_select_page.dart';
import 'package:film_dev/pages/main_page.dart';
import 'package:film_dev/widgets/data.dart';
import 'package:film_dev/widgets/intro_page_item.dart';
import 'package:film_dev/widgets/page_transformer.dart';
import 'package:flutter/material.dart';

class IntroPageView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(560.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: sampleItems.length,
                itemBuilder: (context, index) {
                  final item = sampleItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return IntroPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                    onPageTapped: toNextPage,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void toNextPage(String title) {
    switch (title) {
      case "黑白负片":
        Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
            builder: (BuildContext context) => MainPage()));
        break;
      case "彩色负片":
        Navigator.of(_scaffoldKey.currentState.context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) => C41SelectPage()));
        break;
      case "彩色正片":
        Navigator.of(_scaffoldKey.currentState.context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) => C41SelectPage()));
        break;
      case "电影负片":
        Navigator.of(_scaffoldKey.currentState.context).push(
            new MaterialPageRoute(
                builder: (BuildContext context) => C41SelectPage()));
        break;
    }
  }
}
