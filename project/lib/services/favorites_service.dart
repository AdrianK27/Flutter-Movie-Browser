import '../models/movie.dart';

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

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      _favorites.removeWhere((m) => m.id == movie.id);
    } else {
      _favorites.add(movie);
    }
  }
}