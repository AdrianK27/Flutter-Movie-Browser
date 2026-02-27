import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String apiKey = 'ffe654583ac9a0a3d767329647535074';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    final url = Uri.parse(
      '$baseUrl/movie/popular?api_key=$apiKey&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<Movie>> searchMovies(String query, int page) async {
    final url = Uri.parse(
      '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}