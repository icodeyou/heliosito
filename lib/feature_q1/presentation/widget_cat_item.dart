import 'package:app/feature_q1/data/entity/cat.dart';
import 'package:flutter/material.dart';

class CatItem extends StatelessWidget {
  final CatEntity _cat;
  const CatItem(this._cat);

  @override
  Widget build(BuildContext context) {
    return Text('1 Cat 🐈 : ${_cat.name} from ${_cat.origin}');
  }
}
