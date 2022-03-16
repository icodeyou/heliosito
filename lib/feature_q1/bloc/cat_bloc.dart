import 'dart:convert';

import 'package:app/feature_q1/entity/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../repository/cat_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;
  int page = 1;
  bool isFetching = false;

  CatBloc({
    required this.catRepository,
  }) : super(CatInitialState());

  @override
  Stream<CatState> mapEventToState(CatEvent event) async* {
    if (event is CatFetchEvent) {
      yield CatLoadingState(message: 'Loading Cats');
      final response = await catRepository.getCats(page: page);
      if (response is http.Response) {
        if (response.statusCode == 200) {
          final catsResults = jsonDecode(response.body) as List<CatEntity>;
          yield CatSuccessState(
            cats: [], // catsResults.map((cat) => CatEntity.fromJson(cat)).toList(), //FIXME
          );
          page++;
        } else {
          yield CatErrorState(error: response.body);
        }
      } else if (response is String) {
        yield CatErrorState(error: response);
      }
    }
  }
}
