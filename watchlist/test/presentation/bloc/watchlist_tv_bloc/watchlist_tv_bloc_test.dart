import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tvs.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvBloc =
        WatchlistTvBloc(watchlistTvs: mockGetWatchlistTvs);
  });

  test('initial state should be empty', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () =>
          [WatchlistTvLoading(), WatchlistTvHasData(testTvList)],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      });

   blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
            WatchlistTvLoading(),
            const WatchlistTvError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData, Empty] when data is gotten succesfully but value is empty',
      build: () {
        when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => const Right(<Tv>[]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => [
            WatchlistTvLoading(),
            const WatchlistTvHasData(<Tv>[]),
            WatchlistTvEmpty(),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      });
}
