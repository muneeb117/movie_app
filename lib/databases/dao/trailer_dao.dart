import 'package:floor/floor.dart';
import '../entities/trailer_entity.dart';

@dao
abstract class TrailerDao {
  @Query('SELECT * FROM trailers')
  Future<List<TrailerEntity>> findAllTrailers();

  @Query('SELECT * FROM trailers WHERE movieId = :movieId')
  Future<List<TrailerEntity>> findTrailersByMovieId(int movieId);

  @insert
  Future<void> insertTrailer(TrailerEntity trailer);

  @insert
  Future<void> insertTrailers(List<TrailerEntity> trailers);

  @update
  Future<void> updateTrailer(TrailerEntity trailer);

  @delete
  Future<void> deleteTrailer(TrailerEntity trailer);
}
