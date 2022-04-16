import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of popular tv from repository', () async {
    //arrange
    when(mockTvRepository.getPopularTvs()).thenAnswer(
      (_) async => Right(tTvs),
    );
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getPopularTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}
