import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apyKey = 'f7baea359ce18783053eda3ea74bc4cf';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apyKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apyKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = popularResponse.results;
    notifyListeners();
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apyKey,
      'language': _language,
      'page': '1',
      'query': query,
    });

    final response = await http.get(url);
    if (response.statusCode != 200) return [];

    final searchResponse = PopularResponse.fromJson(response.body);
    return searchResponse.results;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits', {
      'api_key': _apyKey,
      'language': _language,
    });
    final response = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(response.body);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
