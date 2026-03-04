import 'package:flutter/material.dart';
import 'package:project/services/favorites_service.dart';
import 'package:project/models/movie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> favorites = FavoritesService().favorites;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Your Favorites")),
        body: favorites.isEmpty
            ? const Center(
                child: Text(
                  "No favorite movies yet",
                  style: TextStyle(fontSize: 16),
                ),
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
                    title: Text(
                      movie.title.isEmpty
                          ? "Saved Movie ID: ${movie.id}"
                          : movie.title,
                    ),
                    subtitle: Text("Rating: ${movie.rating}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await FavoritesService().toggleFavorite(movie);

                        setState(() {});
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
