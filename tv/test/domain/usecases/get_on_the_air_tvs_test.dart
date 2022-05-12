import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_on_the_air_tvs.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetOnTheAirTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnTheAirTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tv on the air from repository', () async {
    //arrange
    when(mockTvRepository.getOnTheAirTvs()).thenAnswer(
      (_) async => Right(tTvs),
    );
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getOnTheAirTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}
