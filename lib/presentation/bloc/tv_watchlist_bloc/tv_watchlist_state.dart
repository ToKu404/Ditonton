part of 'tv_watchlist_bloc.dart';

class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class SuccessLoadWatchlist extends TvWatchlistState {
  final bool isAddedToWatchlist;

  SuccessLoadWatchlist(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}

class SuccessAddOrRemoveWatchlist extends TvWatchlistState {
  final String message;

  SuccessAddOrRemoveWatchlist({
    this.message = "",
  });

  @override
  List<Object> get props => [message];
}

class FailedAddOrRemoveWatchlist extends TvWatchlistState {
  final String message;

  FailedAddOrRemoveWatchlist({this.message = ""});

  @override
  List<Object> get props => [message];
}
