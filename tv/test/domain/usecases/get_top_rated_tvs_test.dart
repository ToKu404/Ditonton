import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tvs.dart';

import '../../helpers/test_helpers.mocks.dart';


main() {
  late GetTopRatedTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of top rated tv from repository', () async {
    //arrange
    when(mockTvRepository.getTopRatedTvs()).thenAnswer(
      (_) async => Right(tTvs),
    );
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getTopRatedTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}
