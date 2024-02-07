
import '../databases/dao/genre_dao.dart';
import '../databases/entities/genre_entity.dart';
import '../models/genre_model.dart';
import '../services/api/tmdb_api_client.dart';

class GenreRepository {
  final GenreDao genreDao;
  final TmdbApiClient tmdbApiClient;

  GenreRepository({required this.genreDao, required this.tmdbApiClient});

  Future<List<Genre>> getGenresForMovie(int movieId) async {
    try {
      final List<GenreEntity> cachedGenres = await genreDao.findGenresByMovieId(movieId);
      if (cachedGenres.isNotEmpty) {
        return cachedGenres.map((entity) => entity.toGenre()).toList();
      }

      final List<Genre> genresFromApi = await tmdbApiClient.fetchMovieGenres(movieId);

      final List<GenreEntity> genreEntities = genresFromApi.map((genre) => GenreEntity.fromGenre(genre, movieId)).toList();
      await genreDao.insertGenres(genreEntities);

      return genresFromApi;
    } catch (e) {
      throw Exception('Failed to load genres for movie $movieId: $e');
    }
}
}
