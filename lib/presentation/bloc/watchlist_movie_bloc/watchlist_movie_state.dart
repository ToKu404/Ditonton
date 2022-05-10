part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> listMovie;

  WatchlistMovieHasData(this.listMovie);

  @override
  List<Object> get props => [listMovie];
}
