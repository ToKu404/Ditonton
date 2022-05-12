import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_on_the_air_tvs.dart';
import 'package:tv/presentation/bloc/on_the_air_tvs_bloc/on_the_air_tvs_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'on_the_air_tvs_bloc_test.mocks.dart';


@GenerateMocks([GetOnTheAirTvs])
void main() {
  late OnTheAirTvsBloc onTheAirTvsBloc;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;

  setUp(() {
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    onTheAirTvsBloc =
        OnTheAirTvsBloc(getOnTheAirTvs: mockGetOnTheAirTvs);
  });

  test('initial state should be empty', () {
    expect(onTheAirTvsBloc.state, OnTheAirTvEmpty());
  });

  blocTest<OnTheAirTvsBloc, OnTheAirTvsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
        return onTheAirTvsBloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTvs()),
      expect: () => [
            OnTheAirTvLoading(),
            OnTheAirTvHasData(testTvList),
          ],
      verify: (bloc) {
        verify(mockGetOnTheAirTvs.execute());
      });

  blocTest<OnTheAirTvsBloc, OnTheAirTvsState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetOnTheAirTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return onTheAirTvsBloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTvs()),
      expect: () => [
            OnTheAirTvLoading(),
            const OnTheAirTvError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetOnTheAirTvs.execute());
      });
}
