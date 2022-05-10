import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/movie_usecase/get_watchlist_status.dart';
import '../../../domain/usecases/movie_usecase/remove_watchlist.dart';
import '../../../domain/usecases/movie_usecase/save_watchlist.dart';
part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchlistStatus;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistBloc(
      {required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchlistStatus})
      : super(MovieWatchlistEmpty()) {
    on<LoadWatchlistStatus>((((event, emit) async {
      final id = event.id;
      final result = await getWatchlistStatus.execute(id);

      emit(SuccessLoadWatchlist(result));
    })));
    on<AddToWatchlist>(
      ((event, emit) async {
        final movie = event.movieDetail;
        final result = await saveWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.movieDetail.id));
      }),
    );
    on<RemoveFromWatchList>(
      ((event, emit) async {
        final movie = event.movieDetail;
        final result = await removeWatchlist.execute(movie);

        result.fold(
          (failure) {
            emit(FailedAddOrRemoveWatchlist(message: failure.message));
          },
          (success) {
            emit(SuccessAddOrRemoveWatchlist(message: success));
          },
        );
        add(LoadWatchlistStatus(event.movieDetail.id));
      }),
    );
  }
}

//     