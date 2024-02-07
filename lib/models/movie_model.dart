import 'dart:convert';

import '../databases/entities/movie_entity.dart';
import 'genre_model.dart';
import 'trailer_model.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double? rating;
  final List<Genre> genres;
  final List<Trailer> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    this.rating,
    required this.genres,
    required this.trailers,
  });

  factory Movie.fromEntity(MovieEntity entity) {
    List<Genre> genres = jsonDecode(entity.genresJson)
        .map<Genre>((genreJson) => Genre.fromJson(genreJson))
        .toList();
    List<Trailer> trailers = entity.trailersJson != null
        ? jsonDecode(entity.trailersJson)
        .map<Trailer>((trailerJson) => Trailer.fromJson(trailerJson))
        .toList()
        : [];
    return Movie(
      id: entity.id,
      title: entity.title,
      posterPath: entity.posterPath,
      overview: entity.overview,
      releaseDate: entity.releaseDate,
      rating: entity.rating,
      genres: genres,
      trailers: trailers,
    );
  }

  Movie copyWith({
    int? id,
    String? title,
    String? posterPath,
    String? overview,
    String? releaseDate,
    double? rating,
    List<Genre>? genres,
    List<Trailer>? trailers,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      overview: overview ?? this.overview,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      genres: genres ?? this.genres,
      trailers: trailers ?? this.trailers,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterPath: posterPath,
      overview: overview,
      releaseDate: releaseDate,
      rating: rating,
      trailersJson: jsonEncode(trailers.map((trailer) => trailer.toJson()).toList()),
      genresJson: jsonEncode(genres.map((genre) => genre.toJson()).toList()),
    );
  }
}
