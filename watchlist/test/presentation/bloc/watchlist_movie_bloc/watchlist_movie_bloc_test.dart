import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';


@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc =
        WatchlistMovieBloc(watchlistMovies: mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () =>
          [WatchlistMovieLoading(), WatchlistMovieHasData(testMovieList)],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

   blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
            WatchlistMovieLoading(),
            const WatchlistMovieError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData, Empty] when data is gotten succesfully but value is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right(<Movie>[]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
            WatchlistMovieLoading(),
            const WatchlistMovieHasData(<Movie>[]),
            WatchlistMovieEmpty(),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });
}
