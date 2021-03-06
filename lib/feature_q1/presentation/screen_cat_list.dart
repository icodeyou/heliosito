import 'package:app/feature_q1/logic/bloc/cat_bloc.dart';
import 'package:app/feature_q1/logic/bloc/cat_event.dart';
import 'package:app/feature_q1/logic/bloc/cat_state.dart';
import 'package:app/feature_q1/presentation/widget_cat_item.dart';
import 'package:app/ui/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/entity/cat.dart';

class CatListScreen extends StatefulWidget {
  @override
  State<CatListScreen> createState() => _CatListScreenState();
}

class _CatListScreenState extends State<CatListScreen> {
  final List<CatEntity> _cats = [];
  final TextEditingController editingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _noMoreCats = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatBloc, CatState>(
      listener: (context, catState) {
        if (catState is CatErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(catState.error)));
          context.read<CatBloc>().isFetching = false;
        } else if (catState is CatSuccessState) {
          _cats.clear();
          _cats.addAll(catState.cats);
          context.read<CatBloc>().isFetching = false;
          if (catState.noMoreCats) {
            _noMoreCats = true;
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("No more cats !")));
          }
        } else if (catState is CatFilterState) {
          _cats.clear();
          _cats.addAll(catState.filteredCats);
        }
      },
      builder: (context, catState) {
        if ((catState is CatInitialState || catState is CatLoadingState) &&
            _cats.isEmpty) {
          return const CircularProgressIndicator();
        } else if (catState is CatErrorState) {
          return _errorWidget(context, catState);
        } else {
          return _listWidget(context, catState);
        }
      },
    );
  }

  Widget _errorWidget(BuildContext context, CatErrorState catState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {
            context.read<CatBloc>()
              ..isFetching = true
              ..add(const CatFetchEvent());
          },
          icon: const Icon(Icons.refresh),
          label: const Text("Refresh"),
        ),
        const SizedBox(height: 20),
        Text(catState.error, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _listWidget(BuildContext context, CatState catState) {
    return Column(
      children: [
        Container(
          color: UI.backgroundColor,
          padding:
              const EdgeInsets.fromLTRB(UI.pad, UI.pad, UI.pad, UI.pad / 2),
          child: TextField(
            onChanged: (value) {
              context.read<CatBloc>().filterCatsByName(value);
            },
            controller: editingController,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Type the name of a cat",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(UI.cornerRadius)))),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding:
                const EdgeInsets.fromLTRB(UI.pad, UI.pad / 2, UI.pad, UI.pad),
            controller: _scrollController
              ..addListener(() {
                if (!_noMoreCats &&
                    _scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.read<CatBloc>().isFetching) {
                  context.read<CatBloc>()
                    ..isFetching = true
                    ..add(const CatFetchEvent());
                }
              }),
            itemCount: _cats.length + 1,
            separatorBuilder: (context, index) =>
                const SizedBox(height: UI.pad),
            itemBuilder: (context, index) {
              if (index == _cats.length) {
                if (_noMoreCats) {
                  return const SizedBox.shrink();
                }
                if (catState is CatLoadingState) {
                  return _loadingData(catState);
                } else {
                  return _loadMoreData();
                }
              } else {
                return CatItem(_cats[index]);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _loadingData(CatLoadingState catState) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
          top: UI.pad - UI.separatorPadding, bottom: UI.pad),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator()),
          const SizedBox(width: 20),
          Text(catState.message),
        ],
      ),
    );
  }

  Widget _loadMoreData() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
          top: UI.pad - UI.separatorPadding, bottom: UI.pad),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.keyboard_arrow_down),
          SizedBox(width: 10),
          Text("Load more cats ..."),
          SizedBox(width: 10),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
