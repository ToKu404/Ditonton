import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_season.dart';
import 'package:tv/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_season_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeason])
void main() {
  late TvSeasonBloc tvSeasonBloc;
  late MockGetTvSeason getTvSeason;

  setUp(() {
    getTvSeason = MockGetTvSeason();
    tvSeasonBloc = TvSeasonBloc(getTvSeason: getTvSeason);
  });

  test('initial state should be empty', () {
    expect(tvSeasonBloc.state, TvSeasonEmpty());
  });

  const tId = 1;
  const tSeasonNumber = 1;

  blocTest<TvSeasonBloc, TvSeasonState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(getTvSeason.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(testTvSeason));
        return tvSeasonBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeason(tId, tSeasonNumber)),
      expect: () => [TvSeasonLoading(), TvSeasonHasData(testTvSeason)],
      verify: (bloc) {
        verify(getTvSeason.execute(tId, tSeasonNumber));
      });
  blocTest<TvSeasonBloc, TvSeasonState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(getTvSeason.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return tvSeasonBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeason(tId, tSeasonNumber)),
      expect: () => [TvSeasonLoading(), TvSeasonError('Failed')],
      verify: (bloc) {
        verify(getTvSeason.execute(tId, tSeasonNumber));
      });
}
