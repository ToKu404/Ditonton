import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc =
        TopRatedMoviesBloc(topRatedMovies: mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesEmpty());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
          ..thenAnswer((_) async => Right(testMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetTopRatedMovies.execute())
          ..thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
            TopRatedMoviesLoading(),
            TopRatedMoviesError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
