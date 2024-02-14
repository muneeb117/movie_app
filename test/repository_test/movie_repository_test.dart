import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/databases/dao/genre_dao.dart';
import 'package:movie_app/databases/dao/movie_dao.dart';
import 'package:movie_app/databases/entities/genre_entity.dart';
import 'package:movie_app/databases/entities/movie_entity.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/movie_dto_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/trailer_model.dart';
import 'package:movie_app/repository/genre_repository.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/services/api/tmdb_api_client.dart';
import 'package:movie_app/services/api_service.dart';
import 'movie_repository_test.mocks.dart'; // Generated file
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
    mockGenreRepository = MockGenreRepository(); // Make sure this is declared and instantiated
    movieRepository = MovieRepository(apiService: mockApiService, movieDao: mockMovieDao, genreRepository: mockGenreRepository);

    // Add stub for getGenresForMovie here
    when(mockGenreRepository.getGenresForMovie(any)).thenAnswer((_) async => [
      Genre(id: 1, name: "Action"), // Mock genres
      // Add more genres as needed
    ]);
  });


  group('MovieRepository Search Movies Tests', () {
    test('searchMovies fetches and processes movies correctly', () async {
      // Define test variables
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
      // Mock the ApiService to return a predefined list of MovieDTOs
      when(mockApiService.searchMovies(query)).thenAnswer((
          _) async => movieDTOs);

      // Perform the test action
      final movies = await movieRepository.searchMovies(query);

      // Assertions
      expect(movies, isA<List<Movie>>());
      print('Search movies test passed with ${movies.length} movies found.');

      // Verify interactions
      verify(mockApiService.searchMovies(query)).called(1);
    });
  });


  group('MovieRepository Tests to get Upcoming Movie', () {
    test('getUpcomingMovies returns a list of movies', () async {
      // Mock response from the ApiService
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

      // Call the method
      final List<Movie> movies = await movieRepository.getUpcomingMovies();

      // Assertions
      expect(movies, isA<List<Movie>>());
      expect(movies.isNotEmpty, true);
      expect(movies.first.title, equals("Test Movie 1"));

      // Verify that the method was called on ApiService
      verify(mockApiService.fetchUpcomingMovies()).called(1);
    });


  });
}
