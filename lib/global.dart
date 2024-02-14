import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/repository/genre_repository.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/services/api/tmdb_api_client.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/services/storage_service.dart';

import 'databases/app_database.dart';

class Global {
  static late StorageServices storageServices;
  late MovieRepository movieRepository;
  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await dotenv.load(fileName: ".env");
    storageServices = await StorageServices().init();
    final appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final tmdbApiClient = TmdbApiClient();
    final apiService = ApiService(tmdbApiClient);
    final GenreRepository genreRepository = GenreRepository(
        genreDao: appDatabase.genreDao, tmdbApiClient: tmdbApiClient);
    movieRepository = MovieRepository(
      movieDao: appDatabase.movieDao,
      apiService: apiService,
      genreRepository: genreRepository,
    );
  }
}
