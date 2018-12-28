import 'package:film_dev/model/dev_info.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/dev_medic_select_page.dart';
import 'package:flutter/material.dart';

class DevEntry {
  DevEntry(this.title, [this.children = const <DevEntry>[]]);
  final DevInfo title;
  final List<DevEntry> children;
}
class DevEntryItem extends StatelessWidget {
  final DevEntry entry;
  DevEntryItem(this.entry);

  Widget _buildTiles(DevEntry root) {
    if (root.children ==null || root.children.isEmpty)
      return Material(
          color: Colors.grey[800],
          child: new InkWell(
            onTap: (){
//                  toSelectResultPage(root.title);
            },
            child:  MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 0.0),
                  child: ListTile(
                    dense: false,
                    title: Text('${root.title.medicName} '),
                    subtitle: Text(root.title.concentrate?"稀释比: ${root.title.dilution}":"")),
                  ),
                )
            ),
      );
    return new ExpansionTile(
      key: new PageStorageKey<DevEntry>(root),
      title: new Text(root.title.medicName),
      children: root.children.map(_buildTiles).toList(),
    );
  }
    toSelectResultPage(BuildContext context,FilmInfo info) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => DevMedicSelectPage(info)));
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}