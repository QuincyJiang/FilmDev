import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/dev_medic_select_page.dart';
import 'package:flutter/material.dart';

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final FilmInfo title;
  final List<Entry> children;
}
class EntryItem extends StatelessWidget {
  final Entry entry;
  EntryItem(this.entry);

  Widget _buildTiles(Entry root) {
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
                    title: Text('${root.title.brand}  ${root.title.name}'),
                    subtitle: Text("Format: ${root.title.type} ISO: ${root.title.iso}"),
                  ),
                )
            ),
          )
      );
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title.name),
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