
import '../models/trailer_model.dart';
import '../services/api/tmdb_api_client.dart';

class TrailerRepository {
  final TmdbApiClient tmdbApiClient;

  TrailerRepository({required this.tmdbApiClient});

  Future<List<Trailer>> fetchTrailers(int movieId) async {
    try {
      return await tmdbApiClient.fetchMovieTrailers(movieId);
    } catch (e) {
      throw Exception('Failed to load trailers for movie $movieId: $e');
    }
  }
}
