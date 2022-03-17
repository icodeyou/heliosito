import 'dart:convert';

import 'package:http/http.dart' as http;

/// Exception thrown when getCats fails.
class CatRequestFailure implements Exception {}

class CatApiClient {
  CatApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.thecatapi.com';
  final http.Client _httpClient;

  Future<List<dynamic>> getCats(int page, int limit) async {
    try {
      final queryParameters = {
        'limit': '$limit',
        'page': '$page',
      };
      final request = Uri.https(_baseUrl, '/v1/breeds', queryParameters);
      print('Request is : $request');
      final response = await _httpClient.get(request);

      if (response.statusCode != 200) {
        throw CatRequestFailure();
      }

      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      throw "Error fetching list of cats : $e";
    }
  }
}
