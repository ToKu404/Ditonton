import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist, GetWatchListStatus])
void main() {
  late MovieWatchlistBloc watchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistBloc = MovieWatchlistBloc(
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
        getWatchlistStatus: mockGetWatchListStatus);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, MovieWatchlistEmpty());
  });

  final tId = 1;

  group(
    'LoadWatchlisStatus',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit AddWatchlistStatus True',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
        expect: () => [
          SuccessLoadWatchlist(true),
        ],
        verify: (_) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
    },
  );
  group(
    'AddToWatchlist',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit [SuccessAddOrRemoveWatchlist, IsAddedToWatchlist True] when success to add movie to watchlist',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right("Added to Watchlist"));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
        expect: () => [
          SuccessAddOrRemoveWatchlist(message: "Added to Watchlist"),
          SuccessLoadWatchlist(true)
        ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit [FailedAddOrRemoveWatchlist, IsAddedToWatchlist False] when failed to add movie to watchlist',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
        expect: () => [
          FailedAddOrRemoveWatchlist(message: 'Failed'),
          SuccessLoadWatchlist(false)
        ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
    },
  );

   group(
    'RemoveFromWatchlist',
    () {
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit [SuccessAddOrRemoveWatchlist, IsAddedToWatchlist False] when success to remove movie from watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right("Remove from Watchlist"));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchList(testMovieDetail)),
        expect: () => [
          SuccessAddOrRemoveWatchlist(message: "Remove from Watchlist"),
          SuccessLoadWatchlist(false)
        ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
      blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'Should emit [FailedAddOrRemoveWatchlist, IsAddedToWatchlist true] when failed to remove movie from watchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveFromWatchList(testMovieDetail)),
        expect: () => [
          FailedAddOrRemoveWatchlist(message: 'Failed'),
          SuccessLoadWatchlist(true)
        ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
    },
  );
}
