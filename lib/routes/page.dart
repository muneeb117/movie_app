

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/services/api/tmdb_api_client.dart';
import 'package:movie_app/view/screens/movie_detail_screen/bloc/movie_detail_bloc.dart';
import 'package:movie_app/view/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movie_app/view/screens/register/bloc/register_bloc.dart';
import 'package:movie_app/view/screens/search/bloc/search_bloc.dart';
import 'package:movie_app/view/screens/search/search_screen.dart';
import 'package:movie_app/view/screens/sign_in/bloc/signin_blocs.dart';
import 'package:movie_app/view/screens/trailer_screen/bloc/trailer_bloc.dart';
import 'package:movie_app/view/screens/trailer_screen/trailer_screen.dart';
import 'package:movie_app/view/screens/welcome/bloc/welcome_bloc.dart';

import '../global.dart';
import '../repository/movie_repository.dart';
import '../view/screens/application/application_page.dart';
import '../view/screens/application/bloc/app_blocs.dart';
import '../view/screens/more_screen/settings/bloc/setting_bloc.dart';
import '../view/screens/more_screen/settings/settings.dart';
import '../view/screens/movie_list/bloc/movie_list_bloc.dart';
import '../view/screens/movie_list/movie_list.dart';
import '../view/screens/register/register.dart';
import '../view/screens/sign_in/sign_in.dart';
import '../view/screens/welcome/welcome_screen.dart';
import 'name.dart';

class AppPage {
  late TmdbApiClient tmdbApiClient;
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.initial,
      page: const WelcomeScreen(),
      bloc: BlocProvider(
        create: (_) => WelcomeBloc(),
      ),
    ),

    PageEntity(
      route: AppRoutes.signIn,
      page: const SignIn(),
      bloc: BlocProvider(
        create: (_) => SignInBlocs(),
      ),
    ),
    PageEntity(
      route: AppRoutes.register,
      page: const Register(),
      bloc: BlocProvider(
        create: (_) => RegisterBloc(),
      ),
    ),
    PageEntity(
      route: AppRoutes.application,
      bloc: BlocProvider(
        create: (_) => AppBlocs(),
      ),
      page: const ApplicationPage(),
    ),
    PageEntity(
      route: AppRoutes.movieListScreen,
      bloc: BlocProvider(
        create: (context) => MovieListBloc(movieRepository:  RepositoryProvider.of<MovieRepository>(context)),
      ),
      page:  MovieListScreen(),
    ),
    // ),
    PageEntity(
      route: AppRoutes.movieDetailScreen,
      bloc: BlocProvider(
        create: (context) => MovieDetailBloc(movieRepository:  RepositoryProvider.of<MovieRepository>(context)),
      ),
       page:  MovieDetailScreen(),
    ),

    PageEntity(
        route: AppRoutes.settings,
        page: const SettingScreen(),
        bloc: BlocProvider(
          create: (_) => SettingBlocs(),
        )),
    PageEntity(
      route: AppRoutes.trailerScreen,
      bloc: BlocProvider(
        create: (context) => TrailerBloc(),
      ),
      page:  TrailerPlayerScreen(),
    ),
    PageEntity(
      route: AppRoutes.searchScreen,
      bloc: BlocProvider(
        create: (context) => SearchBloc(RepositoryProvider.of<MovieRepository>(context))
      ),
      page:  SearchScreen(),
    ),
  ];

  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];
    for (var bloc in routes) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc as BlocProvider);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes.where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageServices.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.initial && deviceFirstOpen) {
          bool isloggedIn = Global.storageServices.getIsLoggedIn();
          if (isloggedIn) {
            return MaterialPageRoute(
                builder: (_) => ApplicationPage(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => SignIn(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({required this.route, required this.page, this.bloc});
}
