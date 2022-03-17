import 'package:app/feature_q1/logic/bloc/cat_bloc.dart';
import 'package:app/feature_q1/logic/bloc/cat_event.dart';
import 'package:app/feature_q1/logic/bloc/cat_state.dart';
import 'package:app/feature_q1/presentation/widget_cat_item.dart';
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
        if (catState is CatErrorState) {
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  context.watch<CatBloc>()
                    ..isFetching = true
                    ..add(CatFetchEvent());
                },
                icon: Icon(Icons.refresh),
                label: Text("Refresh"),
              ),
              const SizedBox(height: 20),
              Text(catState.error, textAlign: TextAlign.center),
            ],
          );
        }

        debugPrint("Cats are : $_cats");
        bool trailingLoader = (catState is CatLoadingState && _cats.isNotEmpty);
        if (trailingLoader) {
          return Text(catState.message);
        }

        return ListView.separated(
          controller: _scrollController
            ..addListener(() {
              if (_scrollController.offset ==
                      _scrollController.position.maxScrollExtent &&
                  !context.read<CatBloc>().isFetching) {
                context.read<CatBloc>()
                  ..isFetching = true
                  ..add(CatFetchEvent());
              }
            }),
          itemCount: _cats.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return CatItem(_cats[index]);
          },
        );
      },
    );
  }
}
