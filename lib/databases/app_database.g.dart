// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  GenreDao? _genreDaoInstance;

  TrailerDao? _trailerDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movies` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `posterPath` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `rating` REAL, `trailers_json` TEXT NOT NULL, `genres_json` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `genres` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `movieId` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `trailers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `key` TEXT NOT NULL, `name` TEXT NOT NULL, `movieId` INTEGER NOT NULL, FOREIGN KEY (`movieId`) REFERENCES `movies` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  GenreDao get genreDao {
    return _genreDaoInstance ??= _$GenreDao(database, changeListener);
  }

  @override
  TrailerDao get trailerDao {
    return _trailerDaoInstance ??= _$TrailerDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'posterPath': item.posterPath,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'rating': item.rating,
                  'trailers_json': item.trailersJson,
                  'genres_json': item.genresJson
                }),
        _movieEntityUpdateAdapter = UpdateAdapter(
            database,
            'movies',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'posterPath': item.posterPath,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'rating': item.rating,
                  'trailers_json': item.trailersJson,
                  'genres_json': item.genresJson
                }),
        _movieEntityDeletionAdapter = DeletionAdapter(
            database,
            'movies',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'posterPath': item.posterPath,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'rating': item.rating,
                  'trailers_json': item.trailersJson,
                  'genres_json': item.genresJson
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  final UpdateAdapter<MovieEntity> _movieEntityUpdateAdapter;

  final DeletionAdapter<MovieEntity> _movieEntityDeletionAdapter;

  @override
  Future<List<MovieEntity>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movies',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            posterPath: row['posterPath'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double?,
            trailersJson: row['trailers_json'] as String,
            genresJson: row['genres_json'] as String));
  }

  @override
  Future<MovieEntity?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM movies WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            posterPath: row['posterPath'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double?,
            trailersJson: row['trailers_json'] as String,
            genresJson: row['genres_json'] as String),
        arguments: [id]);
  }

  @override
  Future<List<MovieEntity>> searchMovies(String searchQuery) async {
    return _queryAdapter.queryList('SELECT * FROM movies WHERE title LIKE ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            posterPath: row['posterPath'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            rating: row['rating'] as double?,
            trailersJson: row['trailers_json'] as String,
            genresJson: row['genres_json'] as String),
        arguments: [searchQuery]);
  }

  @override
  Future<void> insertMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMovies(List<MovieEntity> movies) async {
    await _movieEntityInsertionAdapter.insertList(
        movies, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMovie(MovieEntity movie) async {
    await _movieEntityUpdateAdapter.update(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(MovieEntity movie) async {
    await _movieEntityDeletionAdapter.delete(movie);
  }
}

class _$GenreDao extends GenreDao {
  _$GenreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreEntityInsertionAdapter = InsertionAdapter(
            database,
            'genres',
            (GenreEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'movieId': item.movieId
                }),
        _genreEntityUpdateAdapter = UpdateAdapter(
            database,
            'genres',
            ['id'],
            (GenreEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'movieId': item.movieId
                }),
        _genreEntityDeletionAdapter = DeletionAdapter(
            database,
            'genres',
            ['id'],
            (GenreEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'movieId': item.movieId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GenreEntity> _genreEntityInsertionAdapter;

  final UpdateAdapter<GenreEntity> _genreEntityUpdateAdapter;

  final DeletionAdapter<GenreEntity> _genreEntityDeletionAdapter;

  @override
  Future<List<GenreEntity>> findAllGenres() async {
    return _queryAdapter.queryList('SELECT * FROM genres',
        mapper: (Map<String, Object?> row) => GenreEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            movieId: row['movieId'] as int));
  }

  @override
  Future<List<GenreEntity>> findGenresByMovieId(int movieId) async {
    return _queryAdapter.queryList('SELECT * FROM genres WHERE movieId = ?1',
        mapper: (Map<String, Object?> row) => GenreEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            movieId: row['movieId'] as int),
        arguments: [movieId]);
  }

  @override
  Future<GenreEntity?> findGenreById(int id) async {
    return _queryAdapter.query('SELECT * FROM genres WHERE id = ?1',
        mapper: (Map<String, Object?> row) => GenreEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            movieId: row['movieId'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertGenre(GenreEntity genre) async {
    await _genreEntityInsertionAdapter.insert(
        genre, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertGenres(List<GenreEntity> genres) async {
    await _genreEntityInsertionAdapter.insertList(
        genres, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateGenre(GenreEntity genre) async {
    await _genreEntityUpdateAdapter.update(genre, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGenre(GenreEntity genre) async {
    await _genreEntityDeletionAdapter.delete(genre);
  }
}

class _$TrailerDao extends TrailerDao {
  _$TrailerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _trailerEntityInsertionAdapter = InsertionAdapter(
            database,
            'trailers',
            (TrailerEntity item) => <String, Object?>{
                  'id': item.id,
                  'key': item.key,
                  'name': item.name,
                  'movieId': item.movieId
                }),
        _trailerEntityUpdateAdapter = UpdateAdapter(
            database,
            'trailers',
            ['id'],
            (TrailerEntity item) => <String, Object?>{
                  'id': item.id,
                  'key': item.key,
                  'name': item.name,
                  'movieId': item.movieId
                }),
        _trailerEntityDeletionAdapter = DeletionAdapter(
            database,
            'trailers',
            ['id'],
            (TrailerEntity item) => <String, Object?>{
                  'id': item.id,
                  'key': item.key,
                  'name': item.name,
                  'movieId': item.movieId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TrailerEntity> _trailerEntityInsertionAdapter;

  final UpdateAdapter<TrailerEntity> _trailerEntityUpdateAdapter;

  final DeletionAdapter<TrailerEntity> _trailerEntityDeletionAdapter;

  @override
  Future<List<TrailerEntity>> findAllTrailers() async {
    return _queryAdapter.queryList('SELECT * FROM trailers',
        mapper: (Map<String, Object?> row) => TrailerEntity(
            id: row['id'] as int?,
            key: row['key'] as String,
            name: row['name'] as String,
            movieId: row['movieId'] as int));
  }

  @override
  Future<List<TrailerEntity>> findTrailersByMovieId(int movieId) async {
    return _queryAdapter.queryList('SELECT * FROM trailers WHERE movieId = ?1',
        mapper: (Map<String, Object?> row) => TrailerEntity(
            id: row['id'] as int?,
            key: row['key'] as String,
            name: row['name'] as String,
            movieId: row['movieId'] as int),
        arguments: [movieId]);
  }

  @override
  Future<void> insertTrailer(TrailerEntity trailer) async {
    await _trailerEntityInsertionAdapter.insert(
        trailer, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertTrailers(List<TrailerEntity> trailers) async {
    await _trailerEntityInsertionAdapter.insertList(
        trailers, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTrailer(TrailerEntity trailer) async {
    await _trailerEntityUpdateAdapter.update(trailer, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrailer(TrailerEntity trailer) async {
    await _trailerEntityDeletionAdapter.delete(trailer);
  }
}
