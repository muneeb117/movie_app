import 'genre_model.dart';
import 'trailer_model.dart';

class MovieDetail {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final double? rating;
  final int? runtime;
  final List<Genre> genres;
  final List<Trailer> trailers;
  MovieDetail({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    this.rating,
    this.runtime,
    required this.genres,
    required this.trailers,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    List<Genre> genresList = (json['genres'] as List<dynamic>?)
        ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
        .toList() ?? [];
    List<Trailer> trailersList = [];
    if (json.containsKey('videos') && json['videos']['results'] != null) {
      trailersList = (json['videos']['results'] as List)
          .map((e) => Trailer.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return MovieDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      rating: (json['vote_average'] as num?)?.toDouble(),
      runtime: json['runtime'] as int?,
      genres: genresList,
      trailers: trailersList,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': rating,
      'runtime': runtime,
      'genres': genres.map((genre) => genre.toJson()).toList(),

    };
  }
}
