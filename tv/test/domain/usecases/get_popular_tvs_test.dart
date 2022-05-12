import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

import '../../helpers/test_helpers.mocks.dart';


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
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getPopularTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}
