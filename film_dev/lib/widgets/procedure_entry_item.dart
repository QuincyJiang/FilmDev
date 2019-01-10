import 'package:film_dev/model/config.dart';
import 'package:film_dev/model/film_info.dart';
import 'package:film_dev/pages/dev_medic_select_page.dart';
import 'package:flutter/material.dart';

class DevProcedureEntry {
  DevProcedureEntry(this.title,[this.children = const <DevProcedureEntry>[]]);
  final Process title;
  final List<DevProcedureEntry> children;
}
class DevProcedureEntryItem extends StatelessWidget {
  final DevProcedureEntry entry;
  final OnProcedureEntryItemClicked onItemClicked;
  DevProcedureEntryItem(this.entry,this.onItemClicked);

  Widget _buildTiles(DevProcedureEntry root) {
    if (root.children ==null || root.children.isEmpty)
      return Material(
          color: Colors.grey[800],
          child: new InkWell(
            onTap: (){
              onItemClicked(root.title);
            },
            child:  MergeSemantics(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0.0, 0.0, 8),
                  child: ListTile(
                    dense: false,
                    title: Text('${root.title.name}'),
                    subtitle: Text("${root.title.name}"),
                  ),
                )
            ),
          )
      );
    return new ExpansionTile(
      key: new PageStorageKey<DevProcedureEntry>(root),
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

typedef OnProcedureEntryItemClicked = void Function(Process info);