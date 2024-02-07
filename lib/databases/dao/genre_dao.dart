import 'package:floor/floor.dart';
import '../entities/genre_entity.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * FROM genres')
  Future<List<GenreEntity>> findAllGenres();
  @Query('SELECT * FROM genres WHERE movieId = :movieId')
  Future<List<GenreEntity>> findGenresByMovieId(int movieId);

  @Query('SELECT * FROM genres WHERE id = :id')
  Future<GenreEntity?> findGenreById(int id);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenre(GenreEntity genre);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGenres(List<GenreEntity> genres);

  @update
  Future<void> updateGenre(GenreEntity genre);

  @delete
  Future<void> deleteGenre(GenreEntity genre);
}
