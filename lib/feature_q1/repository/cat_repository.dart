import 'package:http/http.dart' as http;

class CatRepository {
  static final CatRepository _beerRepository = CatRepository._();
  static const int _perPage = 10;

  CatRepository._();

  factory CatRepository() {
    return _beerRepository;
  }

  Future<dynamic> getCats({
    required int page,
  }) async {
    try {
      return await http.get(
        Uri.parse(
            'https://api.punkapi.com/v2/beers?page=$page&per_page=$_perPage'),
      );
    } catch (e) {
      return e.toString();
    }
  }
}
