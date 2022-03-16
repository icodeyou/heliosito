import 'package:app/feature_q1/bloc/cat_event.dart';
import 'package:app/feature_q1/repository/cat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cat_bloc.dart';

class CatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CatBloc(
              catRepository: CatRepository(),
            )..add(CatFetchEvent()),
        child: Text('Cats 🐈 🐈 🐈'));
  }
}
