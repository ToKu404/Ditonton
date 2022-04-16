import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = "walking dead";

  test('should get list of tvs from the repository', () async {
    //arrange
    when(mockTvRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    //act
    final result = await usecase(Params(query: tQuery));
    //assert
    expect(result, Right(tTvs));
    verify(mockTvRepository.searchTv(tQuery));
    verifyNoMoreInteractions(mockTvRepository);
  });
}