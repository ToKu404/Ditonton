import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv/presentation/bloc/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';


import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvsBloc topRatedTvsBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvsBloc =
        TopRatedTvsBloc(topRatedTvs:mockGetTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(topRatedTvsBloc.state, TopRatedTvsEmpty());
  });

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
        return topRatedTvsBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
            TopRatedTvsLoading(),
            TopRatedTvsHasData(testTvList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      });

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [Loading, Error] when data is gotten failed',
      build: () {
        when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        return topRatedTvsBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
            TopRatedTvsLoading(),
            const TopRatedTvsError('Failed'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      });
}
