import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_season.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_season_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_season_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeason])
main() {
  late TvSeasonNotifier provider;
  late MockGetTvSeason mockGetTvSeason;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeason = MockGetTvSeason();
    provider = TvSeasonNotifier(getTvSeason: mockGetTvSeason)
      ..addListener(() {
        listenerCallCount++;
      });
  });
  final tId = 1;
  final tSeasonNumber = 1;

  group("get tv seasons", () {
    test('should change state to loading when usecase is called', () async {
      //arrange
      when(mockGetTvSeason.execute(tId, tSeasonNumber))
          .thenAnswer((realInvocation) async => Right(testTvSeason));
      //act
      provider.fetchTvSeasons(tId, tSeasonNumber);
      //assert
      expect(provider.state, RequestState.Loading);
    });

     test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTvSeason.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(testTvSeason));
      // act
      await provider.fetchTvSeasons(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeason, testTvSeason);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful',
        () async {
      // arrange
      when(mockGetTvSeason.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeasons(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

  });
}
