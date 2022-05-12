import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_tv.dart';
import 'package:watchlist/domain/usecases/save_watchlist_tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_search_bloc_test.mocks.dart';


@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv, GetWatchlistTvStatus])
void main() {
  late TvWatchlistBloc watchlistBloc;
  late MockGetWatchlistTvStatus mockGetWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    watchlistBloc = TvWatchlistBloc(
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
        getWatchlistStatus: mockGetWatchListStatus);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, TvWatchlistEmpty());
  });

  const tId = 1;

  group(
    'LoadWatchlisStatus',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'Should emit AddWatchlistStatus True',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
        expect: () => [
          const SuccessLoadWatchlist(true),
        ],
        verify: (_) {
          verify(mockGetWatchListStatus.execute(testTvDetail.id));
        },
      );
    },
  );
  group(
    'AddToWatchlist',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'Should emit [SuccessAddOrRemoveWatchlist, IsAddedToWatchlist True] when success to add Tv to watchlist',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right("Added to Watchlist"));
          when(mockGetWatchListStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testTvDetail)),
        expect: () => [
          const SuccessAddOrRemoveWatchlist(message: "Added to Watchlist"),
          const SuccessLoadWatchlist(true)
        ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchListStatus.execute(testTvDetail.id));
        },
      );
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'Should emit [FailedAddOrRemoveWatchlist, IsAddedToWatchlist False] when failed to add Tv to watchlist',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchListStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testTvDetail)),
        expect: () => [
          const FailedAddOrRemoveWatchlist(message: 'Failed'),
          const SuccessLoadWatchlist(false)
        ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchListStatus.execute(testTvDetail.id));
        },
      );
    },
  );

   group(
    'RemoveFromWatchlist',
    () {
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'Should emit [SuccessAddOrRemoveWatchlist, IsAddedToWatchlist False] when success to remove Tv from watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right("Remove from Watchlist"));
          when(mockGetWatchListStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchList(testTvDetail)),
        expect: () => [
          const SuccessAddOrRemoveWatchlist(message: "Remove from Watchlist"),
          const SuccessLoadWatchlist(false)
        ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchListStatus.execute(testTvDetail.id));
        },
      );
      blocTest<TvWatchlistBloc, TvWatchlistState>(
        'Should emit [FailedAddOrRemoveWatchlist, IsAddedToWatchlist true] when failed to remove Tv from watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
          when(mockGetWatchListStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchList(testTvDetail)),
        expect: () => [
          const FailedAddOrRemoveWatchlist(message: 'Failed'),
          const SuccessLoadWatchlist(true)
        ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchListStatus.execute(testTvDetail.id));
        },
      );
    },
  );
}
