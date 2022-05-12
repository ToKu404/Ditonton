import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tv/domain/entities/tv.dart';

import '../dummy_data/dummy_objects.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    tvSearchBloc = TvSearchBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(tvSearchBloc.state, TvSearchEmpty());
  });

  const tQuery = 'spiderman';
  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData, Empty] when data is gotten successfully but data is empty',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Right(<Tv>[]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvSearchLoading(),
      const TvSearchHasData(<Tv>[]),
      TvSearchEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTvChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvSearchLoading(),
      const TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
