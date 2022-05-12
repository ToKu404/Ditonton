import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_season.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';
main() {
  late GetTvSeason usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeason(mockTvRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
 

  test('should get list of tv seasons from reposutory', () async {
    //arrange
    when(mockTvRepository.getTvSeason(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTvSeason));
    //act
    final result = await usecase.execute(tId, tSeasonNumber);
    //assert
    expect(result, Right(testTvSeason));
    verify(mockTvRepository.getTvSeason(tId, tSeasonNumber));
    verifyNoMoreInteractions(mockTvRepository);
  });
}
