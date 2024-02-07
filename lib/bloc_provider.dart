import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/view/screens/application/bloc/app_blocs.dart';
import 'package:movie_app/view/screens/movie_detail_screen/bloc/movie_detail_bloc.dart';
import 'package:movie_app/view/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movie_app/view/screens/movie_list/bloc/movie_list_bloc.dart';
import 'package:movie_app/view/screens/register/bloc/register_bloc.dart';
import 'package:movie_app/view/screens/search/bloc/search_bloc.dart';
import 'package:movie_app/view/screens/sign_in/bloc/signin_blocs.dart';
import 'package:movie_app/view/screens/trailer_screen/bloc/trailer_bloc.dart';
import 'package:movie_app/view/screens/welcome/bloc/welcome_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> allBlocProvider(BuildContext context) {
    return [
      BlocProvider(create: (context) => WelcomeBloc()),
      BlocProvider(create: (context) => SignInBlocs()),
      BlocProvider(create: (context) => RegisterBloc()),
      BlocProvider(create: (context) => AppBlocs()),
      BlocProvider(create: (context) => MovieListBloc( movieRepository: context.read<MovieRepository>())),
      BlocProvider(create: (context) => MovieDetailBloc( movieRepository: context.read<MovieRepository>())),

      BlocProvider(create: (context) => TrailerBloc()),
      BlocProvider(create: (context) => SearchBloc(context.read<MovieRepository>())),

    ];
  }
}
