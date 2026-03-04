import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/movie.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();

  factory FavoritesService() {
    return _instance;
  }

  FavoritesService._internal();

  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  bool isFavorite(Movie movie) {
    return _favorites.any((m) => m.id == movie.id);
  }

  Future<void> toggleFavorite(Movie movie) async {
    if (isFavorite(movie)) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }

    await _saveFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('favorite_ids');

    if (saved != null) {
      _favorites.clear();
      for (var id in saved) {
        _favorites.add(
          Movie(
            id: int.parse(id),
            title: '',
            overview: '',
            posterPath: '',
            rating: 0,
            popularity: 0,
          ),
        );
      }
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = _favorites.map((m) => m.id.toString()).toList();
    await prefs.setStringList('favorite_ids', ids);
  }
}