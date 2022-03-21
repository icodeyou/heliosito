import 'package:app/feature_q1/data/entity/cat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/cat_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;
  int page = 1;
  bool isFetching = false;

  final List<CatEntity> _cats = [];

  CatBloc({
    required this.catRepository,
  }) : super(const CatInitialState()) {
    on<CatFetchEvent>((event, emit) async {
      emit(const CatLoadingState(message: 'Loading Cats'));
      try {
        List<CatEntity> _catsInPage = await catRepository.getCats(page: page);
        _cats.addAll(_catsInPage);
        final debug =
            CatSuccessState(cats: _cats, noMoreCats: _catsInPage.isEmpty);
        emit(debug);
        page++;
      } catch (e) {
        emit(CatErrorState(error: e.toString()));
      }
    });
  }

  void filterCatsByName(String query) {
    List<CatEntity> filteredCats = [];
    _cats.forEach((item) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        filteredCats.add(item);
      }
    });
    emit(CatFilterState(filteredCats: filteredCats));
  }
}
