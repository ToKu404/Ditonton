import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

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
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getTopRatedTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}
