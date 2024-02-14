// Mocks generated by Mockito 5.4.4 from annotations
// in movie_app/test/bloc_test/movie_list_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_app/databases/dao/movie_dao.dart' as _i2;
import 'package:movie_app/models/movie_model.dart' as _i5;
import 'package:movie_app/repository/genre_repository.dart' as _i4;
import 'package:movie_app/repository/movie_repository.dart' as _i6;
import 'package:movie_app/services/api_service.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMovieDao_0 extends _i1.SmartFake implements _i2.MovieDao {
  _FakeMovieDao_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeApiService_1 extends _i1.SmartFake implements _i3.ApiService {
  _FakeApiService_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGenreRepository_2 extends _i1.SmartFake
    implements _i4.GenreRepository {
  _FakeGenreRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovie_3 extends _i1.SmartFake implements _i5.Movie {
  _FakeMovie_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieDao get movieDao => (super.noSuchMethod(
        Invocation.getter(#movieDao),
        returnValue: _FakeMovieDao_0(
          this,
          Invocation.getter(#movieDao),
        ),
      ) as _i2.MovieDao);

  @override
  _i3.ApiService get apiService => (super.noSuchMethod(
        Invocation.getter(#apiService),
        returnValue: _FakeApiService_1(
          this,
          Invocation.getter(#apiService),
        ),
      ) as _i3.ApiService);

  @override
  _i4.GenreRepository get genreRepository => (super.noSuchMethod(
        Invocation.getter(#genreRepository),
        returnValue: _FakeGenreRepository_2(
          this,
          Invocation.getter(#genreRepository),
        ),
      ) as _i4.GenreRepository);

  @override
  _i7.Future<List<_i5.Movie>> getUpcomingMovies() => (super.noSuchMethod(
        Invocation.method(
          #getUpcomingMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i5.Movie>>.value(<_i5.Movie>[]),
      ) as _i7.Future<List<_i5.Movie>>);

  @override
  _i7.Future<List<_i5.Movie>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i7.Future<List<_i5.Movie>>.value(<_i5.Movie>[]),
      ) as _i7.Future<List<_i5.Movie>>);

  @override
  _i7.Future<_i5.Movie> getMovieDetails(int? movieId) => (super.noSuchMethod(
        Invocation.method(
          #getMovieDetails,
          [movieId],
        ),
        returnValue: _i7.Future<_i5.Movie>.value(_FakeMovie_3(
          this,
          Invocation.method(
            #getMovieDetails,
            [movieId],
          ),
        )),
      ) as _i7.Future<_i5.Movie>);
}
