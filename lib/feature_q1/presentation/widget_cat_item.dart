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
        height: 100,
        decoration: Decorations.myBoxDecoration,
        child: Padding(
          padding: EdgeInsets.all(UI.pad),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 100,
                child: CircleAvatar(
                  maxRadius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      NetworkImage("https://cdn2.thecatapi.com/images/9no.jpg"),
                ),
              ),
              Expanded(child: Text("e")),
            ],
          ),
        ));
  }
}
