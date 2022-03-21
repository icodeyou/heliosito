import '../../data/entity/cat.dart';

abstract class CatState {
  const CatState();
}

class CatInitialState extends CatState {
  const CatInitialState();
}

class CatLoadingState extends CatState {
  final String message;

  const CatLoadingState({
    required this.message,
  });
}

class CatSuccessState extends CatState {
  final List<CatEntity> cats;
  final bool noMoreCats;

  const CatSuccessState({
    required this.cats,
    required this.noMoreCats,
  });
}

class CatFilterState extends CatState {
  final List<CatEntity> filteredCats;

  const CatFilterState({
    required this.filteredCats,
  });
}

class CatErrorState extends CatState {
  final String error;

  const CatErrorState({
    required this.error,
  });
}
