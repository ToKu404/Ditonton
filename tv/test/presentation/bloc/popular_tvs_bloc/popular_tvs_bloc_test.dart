import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import '../../../dummy_data/dummy_objects.dart';
import 'popular_tvs_bloc_test.mocks.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';
import 'package:tv/presentation/bloc/popular_tvs_bloc/popular_tvs_bloc.dart';


@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsBloc popularTvsBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvsBloc =
        PopularTvsBloc(popularTvs:mockGetPopularTvs);
  });

  test('initial state should be empty', () {
    expect(popularTvsBloc.state, PopularTvsEmpty());
  });

  blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
            PopularTvsLoading(),
            PopularTvsHasData(testTvList),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
      });

  blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
            PopularTvsLoading(),
            const PopularTvsError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
      });
}
