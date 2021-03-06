import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tvs.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';


void main() {
  late GetWatchlistTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvs(mockTvRepository);
  });

  
  test('should get wathlist tvs from repository', () async {
    //arrange
    when(mockTvRepository.getWatchlistTvs()).thenAnswer(
      (_) async => Right(testTvList),
    );
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(testTvList));
  });
}
