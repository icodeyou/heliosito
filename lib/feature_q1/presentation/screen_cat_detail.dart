import 'package:app/ui/styles/constants.dart';
import 'package:flutter/material.dart';

import '../data/entity/cat.dart';
import 'arguments.dart';

class CatDetailScreen extends StatelessWidget {
  const CatDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final CatEntity? _cat = getArguments(context);

    if (_cat == null) {
      print("Can't get cat argument");
      Navigator.pop(context);
      return Scaffold();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cat information'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(UI.pad),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                    "https://cdn2.thecatapi.com/images/M9p3Ql5GH.jpg"),
              ),
              SizedBox(height: 20),
              Text(
                _cat.name,
                style: TextStyle(fontSize: UI.textXL),
              ),
              SizedBox(height: 20),
              Text(
                'ID : ${_cat.id}',
                style: TextStyle(fontSize: UI.textM),
              ),
              SizedBox(height: 5),
              Text(
                'Origin : ${_cat.origin}',
                style: TextStyle(fontSize: UI.textM),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  CatEntity? getArguments(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Arguments?;
    if (arguments?.cat == null) {
      return null;
    }
    return (arguments?.cat)!;
  }
}
