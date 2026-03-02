import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../models/movie.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
Widget build(BuildContext context) {
  final List<Movie> favorites = FavoritesService().favorites;

  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text("No favorite movies yet"),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];

                return ListTile(
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(width: 50),
                  title: Text(movie.title),
                  subtitle: Text("Rating: ${movie.rating}"),
                );
              },
            ),
    ),
  );
}
}