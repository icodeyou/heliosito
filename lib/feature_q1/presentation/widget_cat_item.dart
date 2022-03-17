import 'package:app/feature_q1/data/entity/cat.dart';
import 'package:app/ui/styles/constants.dart';
import 'package:app/ui/styles/decorations.dart';
import 'package:flutter/material.dart';

class CatItem extends StatelessWidget {
  final CatEntity _cat;
  const CatItem(this._cat);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Decorations.myBoxDecoration,
        child: Padding(
          padding: EdgeInsets.all(UI.pad),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  "https://cdn2.thecatapi.com/images/M9p3Ql5GH.jpg"),
            ),
            SizedBox(width: UI.pad),
            Expanded(
                child: Column(children: [
              CatField("ID : ", _cat.id),
              CatField("Name : ", _cat.name),
              CatField("Origin : ", _cat.origin),
            ])),
          ]),
        ));
  }

  Widget CatField(String field, String value) {
    return Row(
      children: [
        Text(
          '$field : ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
