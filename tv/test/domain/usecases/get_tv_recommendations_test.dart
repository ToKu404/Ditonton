import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helpers.mocks.dart';


main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  const tId = 1;
  final tTvs = <Tv>[];

  test('should get list of tv recommendations from repository', () async {
    //arrange
    when(mockTvRepository.getTvRecommendations(tId)).thenAnswer(
      (_) async => Right(tTvs),
    );
    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getTvRecommendations(tId));
    verifyNoMoreInteractions(mockTvRepository);
  });
}
