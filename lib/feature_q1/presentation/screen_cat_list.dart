import 'package:app/feature_q1/logic/bloc/cat_bloc.dart';
import 'package:app/feature_q1/logic/bloc/cat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/entity/cat.dart';

class CatListScreen extends StatelessWidget {
  List<CatEntity> _cats = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatBloc, CatState>(
      listener: (context, catState) {
        if (catState is CatLoadingState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(catState.message)));
        } else if (catState is CatErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(catState.error)));
          context.watch<CatBloc>().isFetching = false;
        } else if (catState is CatSuccessState && catState.cats.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No more cats")));
        }
      },
      builder: (context, catState) {
        if ((catState is CatInitialState || catState is CatLoadingState) &&
            _cats.isEmpty) {
          return CircularProgressIndicator();
        } else if (catState is CatSuccessState) {
          _cats.addAll(catState.cats);
          context.watch<CatBloc>().isFetching = false;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } else if (catState is CatErrorState && _cats.isEmpty) {
          return Text("Error : ${catState.error}");
        }
        return Text("Cats : $_cats");
      },
    );
  }
}
