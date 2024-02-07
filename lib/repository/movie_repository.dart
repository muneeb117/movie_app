import 'package:movie_app/repository/genre_repository.dart';
import '../databases/dao/movie_dao.dart';
import '../models/movie_model.dart';
import '../models/movie_dto_model.dart';
import '../models/genre_model.dart';
import '../models/trailer_model.dart';
import '../services/api_service.dart';

class MovieRepository {
  final MovieDao movieDao;
  final ApiService apiService;
  final GenreRepository genreRepository;

  MovieRepository({
    required this.movieDao,
    required this.apiService,
    required this.genreRepository,
  });

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      List<MovieDTO> movieDTOs = await apiService.fetchUpcomingMovies();
      List<Movie> movies = [];
      for (var dto in movieDTOs) {
        List<Genre> genres = await genreRepository.getGenresForMovie(dto.id);
        Movie movie = dto.toDomainModel().copyWith(genres: genres);
        movies.add(movie);
      }
      return movies;
    } catch (e) {
      throw Exception('Failed to fetch upcoming movies: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      List<MovieDTO> movieDTOs = await apiService.searchMovies(query);
      List<Movie> movies = [];
      for (var dto in movieDTOs) {
        List<Genre> genres = await genreRepository.getGenresForMovie(dto.id);
        Movie movie = dto.toDomainModel().copyWith(genres: genres);
        movies.add(movie);
      }
      return movies;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
  Future<Movie> getMovieDetails(int movieId) async {
    try {
      var cachedMovie = await movieDao.findMovieById(movieId);
      if (cachedMovie != null) {
        return Movie.fromEntity(cachedMovie);
      }

      MovieDTO movieDTO = await apiService.fetchMovieDetails(movieId);
      List<Genre> genres = await genreRepository.getGenresForMovie(movieId);

      List<Trailer> trailers = await apiService.fetchMovieTrailers(movieId);

      Movie movie = movieDTO.toDomainModel().copyWith(
        genres: genres,
        trailers: trailers,
      );

      return movie;
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }


}
