import 'package:dio/dio.dart';
import 'package:movie_app/models/movie_dto_model.dart';
import '../../models/genre_model.dart';
import '../../models/trailer_model.dart';
import '../api_constants.dart';

class TmdbApiClient {
  final Dio _dio = Dio();

  TmdbApiClient() {
    _dio.options.baseUrl = Constants.apiBaseUrl;
    _dio.options.queryParameters = {'api_key': Constants.apiKey};
  }

  Future<List<MovieDTO>> fetchUpcomingMovies() async {
    try {
      final response = await _dio.get('/movie/upcoming');
      return (response.data['results'] as List)
          .map((json) => MovieDTO.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }

  Future<MovieDTO> fetchMovieDetails(int movieId) async {
    try {
      final movieResponse = await _dio.get('/movie/$movieId', queryParameters: {
        'append_to_response': 'videos', // Include videos in the response
      });

      // Assuming MovieDTO.fromJson method is capable of handling genres and trailers
      return MovieDTO.fromJson(movieResponse.data);
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }

  Future<List<MovieDTO>> searchMovies(String query) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {'query': query});
      return (response.data['results'] as List)
          .map((json) => MovieDTO.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }
  Future<List<Trailer>> fetchMovieTrailers(int movieId) async {
    try {
      final url = '/movie/$movieId/videos';
      final response = await _dio.get(url, queryParameters: {
        'api_key': Constants.apiKey,
      });

      if (response.statusCode == 200) {
        List<Trailer> trailers = [];
        if (response.data['results'] != null) {
          trailers = (response.data['results'] as List)
              .where((json) => json['site'] == "YouTube" && json['type'] == 'Trailer')
              .map((json) => Trailer.fromJson(json))
              .toList();
        }

        trailers.forEach((trailer) {
          print("Fetched trailer key: ${trailer.key}");
        });

        return trailers;
      } else {
        throw Exception('Failed to load trailers with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load movie trailers: ${e.message}');
    }
  }

  Future<List<Genre>> fetchMovieGenres(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId', queryParameters: {
        'api_key': Constants.apiKey,
        'append_to_response': 'genres'
      });
      if (response.data['genres'] != null) {
        return (response.data['genres'] as List).map((genre) => Genre.fromJson(genre)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch genres for movie $movieId: $e');
    }
  }
  Future<List<Genre>> fetchGenres() async {
    try {
      final response = await _dio.get('/genre/movie/list');
      return (response.data['genres'] as List)
          .map((json) => Genre.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load genres: $e');
    }
  }

}
