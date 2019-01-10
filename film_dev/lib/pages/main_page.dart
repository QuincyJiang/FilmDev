import 'package:film_dev/pages/about_page.dart';
import 'package:film_dev/pages/all_films_page.dart';
import 'package:film_dev/pages/c41_select_page.dart';
import 'package:film_dev/pages/collection_page.dart';
import 'package:film_dev/pages/donate_page.dart';
import 'package:film_dev/pages/help_page.dart';
import 'package:film_dev/pages/tips_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}
class _MainPageState extends State<MainPage> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const platform = const MethodChannel('com.jiangxq.filmdev/menu');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 4,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  alignment: Alignment.center,
                  onPressed: openDrawer,
                ),),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TabBar(
                tabs: [
                  Tab(text: "BW"),
                  Tab(text: "C41"),
                  Tab(text: "E6"),
                  Tab(text: "ECN2"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                AllFilmSelectPage(),
                C41SelectPage(),
                C41SelectPage(),
                C41SelectPage(),
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: Container(
                      child: new FlareActor("assets/title.flr",
                          alignment:Alignment.center,
                          fit:BoxFit.contain,
                          animation:"enter"),
                      constraints:  BoxConstraints.expand(height: 150),
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    // DrawerHeader consumes top MediaQuery padding.
                    removeTop: true,
                    child: Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              // The initial contents of the drawer.
                              FadeTransition(
                                opacity: _drawerContentsOpacity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.favorite),
                                      title: const Text('收藏'),
                                      onTap: toCollectionPage,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.help),
                                      title: const Text('帮助'),
                                      onTap: toHelpPage,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text('Tips'),
                                      onTap: toTipsPage,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.info),
                                      title: const Text('关于'),
                                      onTap: toAboutPage,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.monetization_on),
                                      title: const Text('捐赠'),
                                      onTap: toDonatePage,
                                    ),ListTile(
                                      leading: const Icon(Icons.share),
                                      title: const Text('分享'),
                                      onTap: shareApp,
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.update),
                                      title: const Text('更新'),
                                      onTap: checkUpdate,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void openDrawer(){
    _scaffoldKey.currentState.openDrawer();
  }

  void shareApp(){
    platform.invokeMethod("shareApp");
  }
  void checkUpdate(){
    platform.invokeMethod("checkUpdate");
  }


  void toCollectionPage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => CollectionPage()));
  }
  void toHelpPage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => HelpPage()));
  }
  void toAboutPage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => AboutPage()));
  }
  void toTipsPage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => TipsPage()));
  }
  void toDonatePage(){
    Navigator.of(_scaffoldKey.currentState.context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DonatePage()));
  }
}