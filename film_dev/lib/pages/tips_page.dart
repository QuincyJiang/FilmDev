import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
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
                        Container(
                          child: new FlareActor("assets/tips.flr",
                              alignment:Alignment.center,
                              fit:BoxFit.contain,
                              animation:"enter"),
                          constraints:  BoxConstraints.expand(height: 150),
                        ),
                        Center(
                          child: Padding(padding:EdgeInsets.all(10),
                            child: Text("冲洗黑白胶卷的常见问题\n",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                              ),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Center(
                          child: Padding(padding:EdgeInsets.all(10),
                            child: Text("作者不详",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                              ),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Center(
                          child: Padding(padding:EdgeInsets.all(20),
                            child: Text("1．底片发黑、反差悬殊：显影温度太高或显影时间太长所致。应检查药温，控制显影时间。"
                                "\n\n2．底片发白，影像低弱：显影温度太低，或显影时间不足，或显影剂氧化失效。应检查上述三项内容"
                                "\n\n3．底片有划痕：冲片或水洗过程中划伤药膜。在操作过程中避免划伤，特别最后水洗时应加小心。"
                                "\n\n4．底片不透、黑白不分明：定影失效或定影时间过短。换新鲜定影液或加长定影时间。"
                                "\n\n5．底片上有条纹、药膜不均匀：显影过程中搅拌不均匀，或受室内温差影响。 "
                                "\n\n6．底片上有皱纹，水洗温度太高或显影液、定影液温度太高。使用坚膜定影液、使水降温、药水恒温。"
                                "\n\n7．底片上有白点或黑点，显影液，定影液或水中含有杂质及细砂尘土。为防止杂质、细砂，尘土，可将显影液与定影液过滤，用棉纱过滤水笼头，并在干燥时避免灰尘粘污。 "
                                "\n\n8．底片一部分有影像，一部分发黑：暗室漏光或拍摄过程中照相机漏光，或取、上胶卷时漏光。检查暗室与照相机，注意避免漏光。",
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                              ),
                              textAlign: TextAlign.left,),
                          ),
                        ),
                      ],))))
    );
  }
}
