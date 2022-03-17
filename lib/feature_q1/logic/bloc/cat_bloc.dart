import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/cat_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;
  int page = 1;
  bool isFetching = false;

  CatBloc({
    required this.catRepository,
  }) : super(const CatInitialState()) {
    on<CatFetchEvent>((event, emit) async {
      emit(const CatLoadingState(message: 'Loading Cats'));
      try {
        final cats = await catRepository.getCats(page: page);
        emit(CatSuccessState(cats: cats));
        page++;
      } catch (e) {
        emit(CatErrorState(error: e.toString()));
      }
    });
  }
}
