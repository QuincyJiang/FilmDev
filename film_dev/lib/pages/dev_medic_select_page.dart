import 'package:film_dev/model/film_info.dart';
import 'package:flutter/material.dart';

class DevMedicSelectPage extends StatefulWidget {
  final FilmInfo _film;
  DevMedicSelectPage(this._film);

  @override
  _DevMedicSelectPageState createState() => _DevMedicSelectPageState();
}

class _DevMedicSelectPageState extends State<DevMedicSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Film: ${widget._film.name} \n"
          "Iso： ${widget._film.iso} \n"
      "Brand: ${widget._film.brand} \n"
          "ID: ${widget._film.id}"),
    );
  }
}
