

import 'package:floor/floor.dart';
import '../entities/movie_entity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM movies')
  Future<List<MovieEntity>> findAllMovies();

  @Query('SELECT * FROM movies WHERE id = :id')
  Future<MovieEntity?> findMovieById(int id);

  @Query('SELECT * FROM movies WHERE title LIKE :searchQuery')
  Future<List<MovieEntity>> searchMovies(String searchQuery);

  @insert
  Future<void> insertMovie(MovieEntity movie);

  @insert
  Future<void> insertMovies(List<MovieEntity> movies);

  @update
  Future<void> updateMovie(MovieEntity movie);

  @delete
  Future<void> deleteMovie(MovieEntity movie);

}
