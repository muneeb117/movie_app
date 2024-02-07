import 'package:floor/floor.dart';
import '../../models/genre_model.dart';
@Entity(tableName: 'genres')
class GenreEntity {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final int movieId;
  GenreEntity({
    required this.id,
    required this.name,
    required this.movieId,
  });

  Genre toGenre() {
    return Genre(id: this.id, name: this.name);
  }

  static GenreEntity fromGenre(Genre genre, int movieId) {
    return GenreEntity(
      id: genre.id,
      name: genre.name,
      movieId: movieId,
    );
  }
}
