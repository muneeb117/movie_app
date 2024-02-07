import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/genre_dao.dart';
import 'dao/movie_dao.dart';
import 'dao/trailer_dao.dart';
import 'entities/genre_entity.dart';
import 'entities/movie_entity.dart';
import 'entities/trailer_entity.dart';

part 'app_database.g.dart';


@Database(version: 1, entities: [MovieEntity, GenreEntity, TrailerEntity])

abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  GenreDao get genreDao;
  TrailerDao get trailerDao;
}

