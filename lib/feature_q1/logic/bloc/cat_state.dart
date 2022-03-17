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

  const CatSuccessState({
    required this.cats,
  });
}

class CatErrorState extends CatState {
  final String error;

  const CatErrorState({
    required this.error,
  });
}
