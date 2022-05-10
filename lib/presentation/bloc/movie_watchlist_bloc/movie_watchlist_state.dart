part of 'movie_watchlist_bloc.dart';

class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class SuccessLoadWatchlist extends MovieWatchlistState {
  final bool isAddedToWatchlist;

  SuccessLoadWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

class SuccessAddOrRemoveWatchlist extends MovieWatchlistState {
  final String message;

  SuccessAddOrRemoveWatchlist({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}

class FailedAddOrRemoveWatchlist extends MovieWatchlistState {
  final String message;

  FailedAddOrRemoveWatchlist({this.message = ""});

  @override
  List<Object> get props => [message];
}
