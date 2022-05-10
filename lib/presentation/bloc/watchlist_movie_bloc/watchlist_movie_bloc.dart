import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies watchlistMovies;

  WatchlistMovieBloc({required this.watchlistMovies})
      : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>(((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await watchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (movies) {
          emit(WatchlistMovieHasData(movies));
          if (movies.isEmpty) {
            emit(WatchlistMovieEmpty());
          }
        },
      );
    }));
  }
}
