import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/repository/genre_repository.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/routes/page.dart';
import 'package:movie_app/services/api/tmdb_api_client.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/utils/colors_list.dart';
import 'databases/app_database.dart';
import 'global.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await Global.init();
  await dotenv.load(fileName: ".env");


  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final tmdbApiClient = TmdbApiClient();
  final apiService= ApiService(tmdbApiClient);
  final GenreRepository genreRepository=GenreRepository(genreDao: appDatabase.genreDao, tmdbApiClient: tmdbApiClient);

  final movieRepository = MovieRepository(
    movieDao: appDatabase.movieDao,
     apiService: apiService, genreRepository: genreRepository,
  );

  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  const MyApp({Key? key, required this.movieRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MovieRepository>.value(
      value: movieRepository,
      child: MultiBlocProvider(
          providers: [...AppPage.allBlocProviders(context)],
          child: ScreenUtilInit(builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              title: 'Movie App',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppPage.generateRouteSettings,
              theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.primaryText,
                  textTheme: GoogleFonts.poppinsTextTheme(
                    Theme.of(context).textTheme,
                  )),
            );
          })),
    );
  }
}
