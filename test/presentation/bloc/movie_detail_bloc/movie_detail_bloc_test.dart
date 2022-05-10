import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(
        getMovieDetail: mockGetMovieDetail,
        getMovieRecommendations: mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  final tId = 1;

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailLoading, MovieDetailHasData, MovieRecommendationLoading, MovieRecommendationHasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
            MovieDetailLoading(),
            MovieDetailHasData(testMovieDetail, testMovieList),
          ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailLoading, MovieRecommendationLoading, MovieDetailHasData, MovieRecommendationError] when data is gotten failed ',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
            MovieDetailLoading(),
            MovieDetailError('Failed'),
          ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [MovieDetailLoading, MovieRecommendationLoading, MovieDetailError] when data is gotten failed ',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
            MovieDetailLoading(),
            MovieDetailError('Failed'),
          ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      });
}
