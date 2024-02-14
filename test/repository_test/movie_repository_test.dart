import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/databases/dao/movie_dao.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_dto_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repository/genre_repository.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/services/api_service.dart';
import 'movie_repository_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ApiService, MovieDao, GenreRepository])
void main() {
  late MockApiService mockApiService;
  late MockMovieDao mockMovieDao;
  late MockGenreRepository mockGenreRepository;
  late MovieRepository movieRepository;

  setUp(() {
    mockApiService = MockApiService();
    mockMovieDao = MockMovieDao();
    mockGenreRepository = MockGenreRepository();
    movieRepository = MovieRepository(apiService: mockApiService, movieDao: mockMovieDao, genreRepository: mockGenreRepository);

    when(mockGenreRepository.getGenresForMovie(any)).thenAnswer((_) async => [
      Genre(id: 1, name: "Action"), // Mock genres
    ]);
  });


  group('MovieRepository Search Movies Tests', () {
    test('searchMovies fetches and processes movies correctly', () async {
      const String query = "the";
      final List<MovieDTO> movieDTOs = [
        MovieDTO(
          id: 1,
          title: "Test Movie 1",
          posterPath: "/testpath1.jpg",
          overview: "Overview 1",
          releaseDate: "2021-01-01",
          rating: 8.0,
          genres: [],
          trailers: [],
        ),
      ];
      when(mockApiService.searchMovies(query)).thenAnswer((
          _) async => movieDTOs);

      final movies = await movieRepository.searchMovies(query);

      expect(movies, isA<List<Movie>>());
      if (kDebugMode) {
        print('Search movies test passed with ${movies.length} movies found.');
      }

      verify(mockApiService.searchMovies(query)).called(1);
    });
  });


  group('MovieRepository Tests to get Upcoming Movie', () {
    test('getUpcomingMovies returns a list of movies', () async {
      final List<MovieDTO> movieDTOs = [
        MovieDTO(
          id: 1,
          title: "Test Movie 1",
          posterPath: "/testpath1.jpg",
          overview: "Overview 1",
          releaseDate: "2021-01-01",
          rating: 8.0,
          genres: [],
          trailers: [],
        ),
      ];

      when(mockApiService.fetchUpcomingMovies()).thenAnswer((_) async => movieDTOs);

      final List<Movie> movies = await movieRepository.getUpcomingMovies();

      expect(movies, isA<List<Movie>>());
      expect(movies.isNotEmpty, true);
      expect(movies.first.title, equals("Test Movie 1"));

      verify(mockApiService.fetchUpcomingMovies()).called(1);
    });


  });
}
