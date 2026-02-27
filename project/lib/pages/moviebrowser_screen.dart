import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class MovieBrowserScreen extends StatefulWidget {
  const MovieBrowserScreen({super.key});

  @override
  State<MovieBrowserScreen> createState() => _MovieBrowserScreenState();
}

class _MovieBrowserScreenState extends State<MovieBrowserScreen> {
  final ScrollController _scrollController = ScrollController();

  List<Movie> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    _fetchMovies();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final List<Movie> newMovies;

      if (_searchQuery.isEmpty) {
        newMovies =
            await ApiService().fetchPopularMovies(page: _currentPage);
      } else {
        newMovies =
            await ApiService().searchMovies(_searchQuery, _currentPage);
      }

      setState(() {
        _movies.addAll(newMovies);
        _currentPage++;
        _hasMore = newMovies.isNotEmpty;
      });
    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.trim();
      _movies.clear();
      _currentPage = 1;
      _hasMore = true;
    });

    _fetchMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Movies"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search movie...",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _onSearch,
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _movies.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _movies.length) {
                  final movie = _movies[index];

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
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}