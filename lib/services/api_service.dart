import 'package:movie_app/models/movie_dto_model.dart';
import '../models/genre_model.dart';
import '../models/trailer_model.dart';
import 'api/tmdb_api_client.dart';

class ApiService {
  final TmdbApiClient _apiClient;

  ApiService(this._apiClient);

  Future<List<MovieDTO>> fetchUpcomingMovies() async {
    try {
      final movies = await _apiClient.fetchUpcomingMovies();
      return movies;
    } catch (e) {
      throw Exception('Failed to fetch upcoming movies: $e');
    }
  }

  Future<MovieDTO> fetchMovieDetails(int movieId) async {
    try {
      final movieDetails = await _apiClient.fetchMovieDetails(movieId);
      return movieDetails;
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }

  Future<List<Genre>> fetchGenres() async {
    try {
      final genres = await _apiClient.fetchGenres();
      return genres;
    } catch (e) {
      throw Exception('Failed to fetch genres: $e');
    }
  }
  Future<List<MovieDTO>> searchMovies(String query) async {
    if (query.isEmpty) {
      return [];
    }
    try {
      final movies = await _apiClient.searchMovies(query);
      return movies;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }


  Future<List<Trailer>> fetchMovieTrailers(int movieId) async {
    try {
      final trailers = await _apiClient.fetchMovieTrailers(movieId);
      return trailers;
    } catch (e) {
      throw Exception('Failed to fetch movie trailers: $e');
    }
  }

}
