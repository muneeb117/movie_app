import 'dart:convert';
import 'package:floor/floor.dart';
import '../../models/genre_model.dart';
import '../../models/movie_model.dart';
import '../../models/trailer_model.dart';

@Entity(tableName: 'movies')
class MovieEntity {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double? rating;
  @ColumnInfo(name: 'trailers_json')
  final String trailersJson;
  @ColumnInfo(name: 'genres_json')
  final String genresJson;

  MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    this.rating,
    required this.trailersJson,
    required this.genresJson,
  });

  factory MovieEntity.fromMovie(Movie movie) {
    return MovieEntity(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      rating: movie.rating,
      trailersJson: jsonEncode(movie.trailers.map((trailer) => trailer.toJson()).toList()),
      genresJson: jsonEncode(movie.genres.map((genre) => genre.toJson()).toList()),
    );
  }

  Movie toMovie() {
    List<Genre> genres = jsonDecode(genresJson).map<Genre>((genreJson) => Genre.fromJson(genreJson)).toList();
    List<Trailer> trailers = jsonDecode(trailersJson).map<Trailer>((trailerJson) => Trailer.fromJson(trailerJson)).toList(); // Deserialize trailers from JSON
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
