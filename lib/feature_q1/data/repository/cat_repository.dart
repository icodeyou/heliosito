import 'package:app/feature_q1/data/dataprovider/cat_api.dart';
import 'package:app/feature_q1/data/entity/cat.dart';

class CatRepository {
  CatRepository({CatApiClient? catApiClient})
      : _catApiClient = catApiClient ?? CatApiClient();

  final CatApiClient _catApiClient;

  static const int _limitPerPage = 30;

  Future<List<CatEntity>> getCats({
    required int page,
  }) async {
    try {
      final rawCats = await _catApiClient.getCats(page, _limitPerPage);
      return rawCats.map((e) => CatEntity.fromJson(e)).toList();
    } catch (e) {
      throw ("Error parsing cat response : $e");
    }
  }
}
