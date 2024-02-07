import 'package:floor/floor.dart';

import 'movie_entity.dart';

@Entity(tableName: 'trailers', foreignKeys: [
  ForeignKey(
    childColumns: ['movieId'],
    parentColumns: ['id'],
    entity: MovieEntity,
  ),
])
class TrailerEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String key;
  final String name;
  final int movieId;

  TrailerEntity({
    this.id,
    required this.key,
    required this.name,
    required this.movieId,
  });
}
