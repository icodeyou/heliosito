import 'package:app/feature_q1/data/repository/cat_repository.dart';
import 'package:app/feature_q1/logic/bloc/cat_event.dart';
import 'package:app/feature_q1/presentation/screen_cat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/cat_bloc.dart';

class MainQ1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CatBloc(
              catRepository: CatRepository(),
            )..add(CatFetchEvent()),
        child: CatListScreen());
  }
}
