// Import the necessary packages
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/databases/dao/genre_dao.dart';
import 'package:movie_app/databases/entities/genre_entity.dart';
import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/repository/genre_repository.dart';
import 'package:movie_app/services/api/tmdb_api_client.dart';
import 'package:movie_app/services/api_service.dart';
import 'movie_repository_test.mocks.dart'; // Generated file
import 'package:mockito/annotations.dart';

// Generate Mock classes
@GenerateMocks([GenreDao, TmdbApiClient])
void main() {
  late MockGenreDao mockGenreDao;
  late MockTmdbApiClient mockTmdbApiClient;
  late GenreRepository genreRepository;

  setUp(() {
    // Initialize mocks
    mockGenreDao = MockGenreDao();
    mockTmdbApiClient = MockTmdbApiClient();
    // Initialize the repository with mocked dependencies
    genreRepository = GenreRepository(genreDao: mockGenreDao, tmdbApiClient: mockTmdbApiClient);
  });

  group('GenreRepository Tests', () {
    test('getGenresForMovie fetches from API when cache is empty', () async {
      final int testMovieId = 123;
      final List<GenreEntity> emptyGenreEntityList = [];
      final List<Genre> testGenresFromApi = [Genre(id: 1, name: "Action")];

      // Setup mock responses
      when(mockGenreDao.findGenresByMovieId(testMovieId)).thenAnswer((_) async => emptyGenreEntityList);
      when(mockTmdbApiClient.fetchMovieGenres(testMovieId)).thenAnswer((_) async => testGenresFromApi);

      // Act
      final genres = await genreRepository.getGenresForMovie(testMovieId);

      // Assert
      expect(genres, isA<List<Genre>>());
      expect(genres.length, equals(testGenresFromApi.length));
      expect(genres.first.name, equals("Action"));

      // Verify interactions
      verify(mockGenreDao.findGenresByMovieId(testMovieId)).called(1);
      verify(mockTmdbApiClient.fetchMovieGenres(testMovieId)).called(1);
      verify(mockGenreDao.insertGenres(any)).called(1); // Ensure we attempt to cache the genres
    });
  });
}
