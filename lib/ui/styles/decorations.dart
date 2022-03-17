import 'package:flutter/material.dart';

import 'constants.dart';

class Decorations {
  static BoxDecoration myBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(UI.cornerRadius)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  static BoxDecoration disabledBoxDecoration = BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.all(Radius.circular(UI.cornerRadius)),
  );
}
