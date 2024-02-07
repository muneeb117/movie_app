import 'package:movie_app/models/genre_model.dart';
import 'package:movie_app/models/trailer_model.dart';

import 'movie_model.dart';

class MovieDTO {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double? rating;
  final List<Genre> genres;
  final List<Trailer> trailers;

  MovieDTO({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    this.rating,
    required this.genres,
    required this.trailers,
  });

  factory MovieDTO.fromJson(Map<String, dynamic> json) {
    // Parse genres
    List<Genre> genres = [];
    if (json['genres'] != null && json['genres'] is List) {
      genres = (json['genres'] as List)
          .map((genreJson) => Genre.fromJson(genreJson as Map<String, dynamic>))
          .toList();
    }
    List<Trailer> trailers = [];
    if (json.containsKey('videos') && json['videos']['results'] != null) {
      trailers = (json['videos']['results'] as List)
          .where((result) => result['type'] == 'Trailer' && result['site'] == 'YouTube')
          .map((trailerJson) => Trailer.fromJson(trailerJson))
          .toList();
    }
    return MovieDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      rating: (json['vote_average'] as num?)?.toDouble(),
      genres: genres,
      trailers: trailers,
    );
  }

  Movie toDomainModel() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath,
      overview: overview,
      releaseDate: releaseDate,
      rating: rating,
      genres: genres,
      trailers: trailers,
    );
  }
}
