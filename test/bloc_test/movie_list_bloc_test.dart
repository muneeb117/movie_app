import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/view/screens/movie_list/bloc/movie_list_bloc.dart';
import 'package:movie_app/view/screens/movie_list/bloc/movie_list_event.dart';
import 'package:movie_app/view/screens/movie_list/bloc/movie_list_state.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([MovieRepository])

void main() {
  group('MovieListBloc Tests', () {
    late MovieListBloc movieListBloc;
    late MockMovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      movieListBloc = MovieListBloc(movieRepository: mockMovieRepository);
    });

    blocTest<MovieListBloc, MovieListState>(
      'emits [MoviesLoadingState, MoviesLoadedState] when FetchUpcomingMoviesEvent is added and movies are fetched successfully',
      build: () => movieListBloc,
      act: (bloc) => bloc.add(FetchUpcomingMoviesEvent()),
      setUp: () {
        // Mock the repository's response when fetching upcoming movies
        when(mockMovieRepository.getUpcomingMovies()).thenAnswer((_) async => [/* List of movies here */]);
      },
      expect: () => [
        isA<MoviesLoadingState>(),
        isA<MoviesLoadedState>(),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [MoviesLoadingState, MoviesErrorState] when FetchUpcomingMoviesEvent is added and fetching movies fails',
      build: () => movieListBloc,
      act: (bloc) => bloc.add(FetchUpcomingMoviesEvent()),
      setUp: () {
        // Mock the repository to throw an exception when fetching upcoming movies
        when(mockMovieRepository.getUpcomingMovies()).thenThrow(Exception('Failed to fetch movies'));
      },
      expect: () => [
        isA<MoviesLoadingState>(),
        isA<MoviesErrorState>(),
      ],
    );

    // Clean up after tests
    tearDown(() {
      movieListBloc.close();
    });
  });
}
