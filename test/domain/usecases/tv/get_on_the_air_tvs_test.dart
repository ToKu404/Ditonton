
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/usecase.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_the_air_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

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
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.getOnTheAirTvs());
    verifyNoMoreInteractions(mockTvRepository);
  });
}