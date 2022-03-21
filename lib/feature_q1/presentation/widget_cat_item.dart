import 'package:app/feature_q1/data/entity/cat.dart';
import 'package:app/feature_q1/presentation/arguments.dart';
import 'package:app/feature_q1/presentation/screen_cat_detail.dart';
import 'package:app/ui/styles/constants.dart';
import 'package:app/ui/styles/decorations.dart';
import 'package:flutter/material.dart';

class CatItem extends StatelessWidget {
  final CatEntity _cat;
  const CatItem(this._cat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: Decorations.myBoxDecoration,
      child: InkWell(
        onTap: () {
          print('Click on cat ${_cat.id}');
          Navigator.pushNamed(context, CatDetailScreen.routeName,
              arguments: Arguments(cat: _cat));
        },
        child: Padding(
          padding: const EdgeInsets.all(UI.pad),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  "https://cdn2.thecatapi.com/images/M9p3Ql5GH.jpg"),
            ),
            const SizedBox(width: UI.pad),
            Expanded(
                child: Column(children: [
              _catField("ID : ", _cat.id),
              _catField("Name : ", _cat.name),
              _catField("Origin : ", _cat.origin),
            ])),
          ]),
        ),
      ),
    );
  }

  Widget _catField(String field, String value) {
    return Row(
      children: [
        Text(
          '$field : ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
