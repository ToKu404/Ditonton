import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecase/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_bloc/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../provider/movie_provider/movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = MovieSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, MovieSearchEmpty());
  });

  final tQuery = 'spiderman';
  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
