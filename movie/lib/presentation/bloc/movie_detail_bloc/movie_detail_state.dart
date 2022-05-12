part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;

  const MovieDetailHasData(
    this.movieDetail,
    this.movieRecommendations,
  );

  @override
  List<Object> get props => [movieDetail, movieRecommendations];
}


class LoadMovieDetailFailureState extends MovieDetailState {
  final String message;

  const LoadMovieDetailFailureState({
    this.message = "",
  });
}

class LoadMovieRecommendationFailureState extends MovieDetailState {
  final String message;

  const LoadMovieRecommendationFailureState({
    this.message = "",
  });
}
